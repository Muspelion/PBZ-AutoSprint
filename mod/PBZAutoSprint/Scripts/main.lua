-- PBZAutoSprint: automatic sprint outside combat for Phantom Blade Zero (single player).
-- An accessibility mod, made with players with motor disabilities in mind. MIT License.
--
-- Facts (from the game files and measurements in the game):
--   * Sprint has no ability or cost: the native locomotion driver switches the attitude to
--     CharacterState.Native.Attitude.Sprinting on IA_Sprint (hold) / IA_SprintSwitch (toggle);
--     GE_Sprinting only overrides the run speed (750 here, jog ~600).
--   * Sprint does NOT use Shachi and does not slow its regeneration (measured), so Shachi plays no part here.
--   * IA_SprintSwitch is ignored during a steady run (it only works while accelerating). Injecting IA_Sprint every
--     frame acts as a held key: sprint starts within 0.2 s at any speed and ends right after the injection stops.
--
-- Rules (only while the player is running on the ground, out of combat, not sneaking or walking):
--   * Sprint, unless an enemy is closer than stopDistance (enter the fight in control, not at full speed).
--
-- Keys: F5 = auto sprint on/off.
-- Settings are remembered in settings.txt next to this mod; set `log = true` below for autosprint.log.

local CFG = {
    enabled = true,
    stopDistance = 2000,       -- uu (20 m): no sprinting closer than this to an enemy
    scanDistance = 8000,       -- uu: enemies further than this are ignored
    levelTolerance = 300,      -- uu: enemies this much higher or lower are on another level and are ignored
    runMinSpeed = 250,         -- uu/s: below this the player is not running
    keyDebounce = 0.25,        -- seconds; only filters a bouncing key, longer feels unresponsive
    resumeMargin = 300,        -- uu: sprint again only this far beyond stopDistance (no flicker at the edge)
    log = false,               -- true = write autosprint.log next to this mod (for bug reports)
}

-- Folder of this mod (…/ue4ss/Mods/PBZAutoSprint/), so nothing depends on where the game is installed.
local MOD_DIR = (function()
    -- Called directly (not through pcall, which would report pcall itself as level 1).
    local info = debug and debug.getinfo and debug.getinfo(1, "S")
    local src = info and info.source or ""
    local dir = src:gsub("^@", ""):gsub("\\", "/"):match("^(.*/)Scripts/[^/]*$")
    return dir or "Mods/PBZAutoSprint/" -- UE4SS runs with the ue4ss folder as working directory
end)()

local LOG_PATH = MOD_DIR .. "autosprint.log"
local logFile = CFG.log and io.open(LOG_PATH, "a") or nil
local function log(...)
    if not logFile then return end
    local parts = {}
    for i = 1, select("#", ...) do parts[#parts + 1] = tostring(select(i, ...)) end
    logFile:write(os.date("%H:%M:%S "), table.concat(parts, "\t"), "\n")
    logFile:flush()
end

local GS = StaticFindObject("/Script/Engine.Default__GameplayStatics")

local S = { refreshAt = 0, scanAt = 0, enemyDist = math.huge, enemyName = nil }

local function valid(o) return o ~= nil and o:IsValid() end

local function findLive(className, outer)
    for _, o in ipairs(FindAllOf(className) or {}) do
        if valid(o) and not o:GetFName():ToString():find("^Default__") then
            if not outer then return o end
            local ok, ow = pcall(function() return o:GetOuter() end)
            if ok and valid(ow) and ow:GetAddress() == outer:GetAddress() then return o end
        end
    end
    return nil
end

local TAGS = {}
local function has(name)
    local t = TAGS[name]
    if not t then t = { TagName = FName(name) } TAGS[name] = t end
    local ok, r = pcall(function() return S.asc:HasMatchingGameplayTag(t) end)
    return ok and r == true
end

-- ---------------------------------------------------------------------------------------------
-- Persistent on/off state.
local STATE_PATH = MOD_DIR .. "settings.txt"

local function stateString() return string.format("enabled=%d\n", CFG.enabled and 1 or 0) end

local function saveState()
    local f = io.open(STATE_PATH, "w")
    if f then f:write(stateString()) f:close() end
    S.stateText = stateString()
end

local function loadState()
    local f = io.open(STATE_PATH, "r")
    if not f then return false end
    local text = f:read("a")
    f:close()
    if text == S.stateText then return false end
    S.stateText = text
    local e = text:match("enabled=(%d)")
    if e then CFG.enabled = e == "1" end
    return true
end

-- ---------------------------------------------------------------------------------------------
-- On-screen tips (game's own text tip; only our own registration is removed).
local TIP_TAG = { TagName = FName("UI.ExtensionPoint.TextTips") }
local TIP_CLASS = "/Game/PBZContent/UI/FrontEnd/WB_TextTipsObj.WB_TextTipsObj_C"

local function statusText() return "Auto Sprint: " .. (CFG.enabled and "ON" or "OFF") end

local function hideTip()
    if S.tipHandle then
        pcall(function()
            local ext = findLive("UIExtensionSubsystem")
            if valid(ext) then ext:UnregisterExtension(S.tipHandle) end
        end)
    end
    S.tipHandle, S.tipHideAt = nil, nil
end

local function showTip(text, now)
    hideTip()
    local ok, err = pcall(function()
        local ext = findLive("UIExtensionSubsystem")
        local cls = StaticFindObject(TIP_CLASS)
        if not (valid(ext) and valid(cls)) then
            log("TIP skipped", "ext=" .. tostring(valid(ext)), "class=" .. tostring(valid(cls)))
            return
        end
        -- Clear the slot first (as PBZAutoCombat does): a tip still registered there hides a new one.
        ext:UnregisterExtensionByTag(TIP_TAG)
        local obj = StaticConstructObject(cls, ext)
        obj.ShowText = FText(text)
        S.tipHandle = ext:K2_RegisterExtensionAsData(TIP_TAG, obj, 0)
    end)
    log("TIP", text, ok and "" or tostring(err))
    S.tipHideAt = (now or 0) + 3.0
end

-- ---------------------------------------------------------------------------------------------
local function possessedPawn()
    for _, pc in ipairs(FindAllOf("PlayerController") or {}) do
        if valid(pc) and not pc:GetFName():ToString():find("^Default__") then
            local ok, p = pcall(function() return pc.Pawn end)
            if ok and valid(p) then return p end
        end
    end
    return findLive("BP_Renewal_Hun_C")
end

local function refresh(now)
    S.pawn = possessedPawn()
    S.asc, S.input = nil, nil
    if not valid(S.pawn) then return end
    S.asc = findLive("PBZAbilitySystemComponent", S.pawn)
    S.input = findLive("EnhancedInputLocalPlayerSubsystem")
    -- Looked up here, not at load: mods start in the main menu, before this input asset is loaded.
    if not valid(S.sprintAction) then
        S.sprintAction = StaticFindObject("/SGameLocomotionDriver/Input/IA_Sprint.IA_Sprint")
        log("IA_Sprint", valid(S.sprintAction) and "found" or "not loaded yet")
    end
    S.refreshAt = now + 1.0
end

-- Hostile characters are BP_Monster_* (allied helpers carry "NPChelper"/"Helper" in the class name).
local function isEnemyClass(name)
    return name:find("^BP_Monster_") and not name:find("Helper") and not name:find("helper")
end

local function enemyAlive(c)
    local alive = true
    pcall(function()
        local a = findLive("BasicAttributeSet", c)
        if valid(a) and a.Health.CurrentValue <= 0 then alive = false end
    end)
    return alive
end

local function scanEnemies()
    local me = S.pawn:K2_GetActorLocation()
    local best, bestName = math.huge, nil
    for _, c in ipairs(FindAllOf("Character") or {}) do
        if valid(c) then
            local cname = c:GetClass():GetFName():ToString()
            if isEnemyClass(cname) then
                local p = c:K2_GetActorLocation()
                local d = math.sqrt((p.X - me.X) ^ 2 + (p.Y - me.Y) ^ 2)
                local sameLevel = math.abs(p.Z - me.Z) <= CFG.levelTolerance
                if sameLevel and d < best and d < CFG.scanDistance and enemyAlive(c) then best, bestName = d, cname end
            end
        end
    end
    S.enemyDist, S.enemyName = best, bestName
end

-- One frame of a held sprint key.
local function holdSprint()
    if not valid(S.sprintAction) then return end
    local ok, err = pcall(function()
        S.input:InjectInputVectorForAction(S.sprintAction, { X = 1.0, Y = 0.0, Z = 0.0 }, {}, {})
    end)
    if not ok and not S.injectErrorLogged then
        S.injectErrorLogged = true
        log("INJECT error", err)
    end
end

local function tick()
    local clock = os.clock()
    if not (valid(S.pawn) and valid(S.asc) and valid(S.input)) then
        if clock < (S.retryAt or 0) then return end
        S.retryAt = clock + 1.0
        refresh(0)
        if not valid(S.pawn) then return end
    end
    local now = GS:GetTimeSeconds(S.pawn)
    if now >= S.refreshAt then refresh(now) end
    if not (valid(S.asc) and valid(S.input)) then return end

    if clock >= (S.stateCheckAt or 0) then
        S.stateCheckAt = clock + 1.0
        if loadState() then
            log("STATUS (file)", (stateString():gsub("\n", " ")))
            S.tipPending = statusText()
        end
    end
    local pawnAddr = S.pawn:GetAddress()
    if S.announcedPawn ~= pawnAddr then
        S.announcedPawn = pawnAddr
        S.tipPending = statusText()
    end
    if S.tipPending then
        local text = S.tipPending
        S.tipPending = nil
        showTip(text, now)
    elseif S.tipHideAt and now >= S.tipHideAt then
        hideTip()
    end

    -- The held key has to be injected every frame; the decision below runs 10 times a second.
    if S.want then holdSprint() end

    if now - (S.lastLogic or -1) < 0.1 then return end
    S.lastLogic = now

    if now >= S.scanAt then
        S.scanAt = now + 0.5
        scanEnemies()
    end

    local v = S.pawn:GetVelocity()
    local speed = math.sqrt(v.X * v.X + v.Y * v.Y)
    if not CFG.enabled then
        S.want = false
        return
    end

    local running = speed > CFG.runMinSpeed
        and has("CharacterState.Space.Ground")
        and not has("CharacterState.InCombat")
        and not has("CharacterState.Native.Attitude.Sneaking")
        and not has("CharacterState.Native.Attitude.SlowSneaking")
        and not has("CharacterState.Native.Attitude.Walking")

    -- Decide.
    local want, reason = running, nil
    local stopAt = CFG.stopDistance + (S.want and 0 or CFG.resumeMargin)
    if has("CharacterState.InCombat") then
        reason = "combat"
    elseif want and S.enemyDist < stopAt then
        want, reason = false, string.format("enemy %.0f m", S.enemyDist / 100)
    end

    if want ~= (S.want or false) then
        log(want and "START" or "STOP", reason or "", string.format("enemy %s %.0f, speed %.0f", tostring(S.enemyName),
            S.enemyDist == math.huge and -1 or S.enemyDist, speed))
    end
    -- Say why the mod is not sprinting, also when the run starts next to an enemy (at most every 5 s).
    if running and not want and reason and now >= (S.blockTipAt or 0) then
        S.blockTipAt = now + 5
        S.tipPending = "Auto Sprint: running - " .. reason
    end
    S.want = want
end

local errors = 0
LoopInGameThreadAfterFrames(1, function()
    local ok, err = pcall(tick)
    if not ok then
        errors = errors + 1
        if errors <= 20 then log("ERROR", err) end
    end
    return false
end)

pcall(function()
    RegisterKeyBind(Key.F5, function()
        local clock = os.clock()
        if clock - (S.keyAt or -100) < CFG.keyDebounce then return end
        S.keyAt = clock
        CFG.enabled = not CFG.enabled
        if not CFG.enabled then S.want = false end -- stop holding the key on the very next frame
        S.lastLogic = nil                          -- and decide again right away when switched on
        saveState()
        S.tipPending = statusText()
        log("STATUS enabled=" .. tostring(CFG.enabled))
    end)
end)

log("PBZAutoSprint loaded")
if not loadState() then saveState() end
log("STATUS enabled=" .. tostring(CFG.enabled))
print("[PBZAutoSprint] loaded\n")
