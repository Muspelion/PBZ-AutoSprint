# PBZ Auto Sprint

**🇬🇧 English** · [🇵🇱 Polski](README.pl.md) · [🇫🇷 Français](README.fr.md) · [🇪🇸 Español](README.es.md) · [🇺🇦 Українська](README.uk.md)

An accessibility mod for **Phantom Blade Zero** (PC) that **holds sprint for you** while you run, and stops by itself
before enemies and in combat.

> ♿ **This mod was created with players with motor disabilities in mind.** Exploring means holding a button for
> minutes at a time. If that is tiring, painful or impossible for you, this mod does it for you – you only steer.

> ⚠️ **An official, legally purchased version of the game is required for the mod to work.**

Works well together with [**PBZ Auto Parry & Dodge**](https://github.com/Muspelion/PBZ-AutoParryDodge) and
[**PBZ Auto Weapon Switch**](https://github.com/Muspelion/PBZ-AutoWeaponSwitch). Each mod can be installed on its own.

---

## ✨ What it does

- **Sprints while you run** – on the ground, outside combat, unless you sneak or walk. You still choose the direction.
- **Stops 20 m before an enemy** on your level, so you do not rush into a group at full speed.
  Sprint comes back once you are more than 23 m away.
- **Never sprints in combat.**
- Enemies on a different level (more than 3 m higher or lower) are ignored.
- **On-screen messages** – when you load a save, when you press the key, and when an enemy stops the sprint
  (for example *“Auto Sprint: running - enemy 19 m”*).
- **Your setting is remembered** between game sessions.
- **Nothing in the game is modified** – the mod only adds files next to the game.

Sprinting does not use Shachi and does not slow its recovery (measured in the game: 75 seconds of sprinting with
Shachi staying full), so the mod does not need to manage Shachi.

### Tested results (Steam version)

| Situation | Result |
|---|---|
| Running with no enemies near | Reaches full sprint speed (750) |
| Running towards enemies | Sprint ended 4 of 4 times at 18.8–19.9 m |
| Moving away from enemies | Sprint came back from 24 m, with no flicker at the border |
| Combat | No sprint during the whole fight |

## 📋 Requirements

- An **official copy** of Phantom Blade Zero for PC (Windows 10/11).
  - **Steam** – tested ✅
  - **Epic Games Store** – supported by the installer, not tested yet
  - **GOG** – the game is not on GOG at the moment; the installer will find it if it appears there
- An internet connection for the first installation (the installer downloads
  [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS), the free mod loader for Unreal Engine games,
  unless it is already installed).
- The game is **single-player only** and has no anti-cheat. This mod does not touch DRM or online features.

## 🚀 Easy installation (recommended)

1. Download **`PBZ-AutoSprint-v1.0.0.zip`** from the [**Releases**](../../releases/latest) page.
2. Unpack the zip anywhere (for example on the Desktop).
3. **Close the game.**
4. Double-click **`install.bat`**.
   - If Windows shows *“Windows protected your PC”*, click **More info → Run anyway**
     (the installer is a plain text script – you can open `install.ps1` in Notepad to read it).
5. When it says **Done!**, close the window.
6. Start the game normally. After loading a save you will see: `Auto Sprint: ON`

If the game is not found automatically, the installer asks for the game folder:
Steam → right-click Phantom Blade Zero → **Manage → Browse local files**;
Epic → Library → **⋯ → Manage → Installation folder**. Copy that path and paste it into the installer window.

If another PBZ mod is already installed, the installer keeps its UE4SS and just adds this mod.

## 🎮 Controls

| Key | Action |
|---|---|
| **F5** | Auto sprint ON / OFF |

The change is shown on screen and saved automatically. Your own sprint button keeps working as usual.

## 🗑️ Uninstall

Close the game and double-click **`uninstall.bat`**. It removes the mod. UE4SS is removed only if this
installer put it there **and** no other PBZ mod still uses it (you will be asked first).

## 🔧 Manual installation (advanced)

1. Open the game folder that contains the large `PBZ.exe` (Steam: `…\steamapps\common\PBZ\platform\steam\`).
2. If UE4SS is not installed yet: download the latest `UE4SS_v…zip` (not `zDEV-…`) from
   [UE4SS experimental-latest](https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest)
   and unpack it there, so that `dwmapi.dll` and the `ue4ss` folder sit next to `PBZ.exe`.
3. Copy the contents of this package's `ue4ss-config` folder into that `ue4ss` folder
   (`MemberVariableLayout.ini` and the `UE4SS_Signatures` folder). The game needs this config to run UE4SS.
4. Copy the `mod\PBZAutoSprint` folder into `ue4ss\Mods\`.
5. Open `ue4ss\Mods\mods.txt` and add the line `PBZAutoSprint : 1` above the `Keybinds` line.

## ❓ Troubleshooting

- **No message after loading a save** → check that `ue4ss\Mods\mods.txt` contains `PBZAutoSprint : 1`
  and look at `ue4ss\UE4SS.log` for errors.
- **The character does not sprint** → check the message after pressing F5 (it should say ON), and whether an enemy is
  close by. Sprint also stays off while sneaking or walking.
- **The game does not start or crashes at start-up** → run `uninstall.bat` (or delete `dwmapi.dll` next to
  `PBZ.exe`). A game update can change the code that UE4SS needs; check this page for an updated version.
- **Something else is wrong** → open `ue4ss\Mods\PBZAutoSprint\Scripts\main.lua` in Notepad, change
  `log = false` to `log = true`, play, and attach `autosprint.log` (from the mod folder) to an
  [issue](../../issues).

## ⚙️ How it works (short)

The game has no “start sprinting” function: sprint is controlled only by the sprint button. While the rules allow it,
the mod presses that button every frame through the game's own input system, exactly like a held key. Ten times a
second it checks your speed, your state and the distance to the nearest enemy. The mod is a
[UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) Lua script; it ships no game files.

## 🙏 Credits

- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) – the Unreal Engine scripting system (MIT).
- Phantom Blade Zero UE4SS config (`MemberVariableLayout.ini`, signatures) –
  [KintaroModding](https://github.com/KintaroModding), submitted as
  [UE4SS-RE/RE-UE4SS#1484](https://github.com/UE4SS-RE/RE-UE4SS/pull/1484); signature patterns from the UE4SS
  team's custom game configs (MIT).
- Built with the help of **Claude Code** (Anthropic's Claude AI), which analysed the game's logic and wrote
  the mod together with the author; all results were tested in the real game.

## 📄 License & disclaimer

Code: [MIT License](LICENSE). This is an unofficial fan project, not affiliated with or endorsed by S-GAME.
Phantom Blade Zero is a trademark of S-GAME. Use at your own risk – keep a backup of your save files.

See the [changelog](CHANGELOG.md) for version history.
