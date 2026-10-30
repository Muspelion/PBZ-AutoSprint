# Changelog

## v1.0.1 – 2026-10-30

- Fixed: the mod no longer gets in the way of climbing and its on-screen prompt. Sprint pauses in climb, wall-run,
  ladder and rope zones and during those moves, then returns by itself.

## v1.0.0 – 2026-10-30

First public release.

- Holds sprint while the player runs on the ground outside combat (not while sneaking or walking).
- Stops 20 m before an enemy on the same level (more than 3 m higher or lower is ignored); sprint returns beyond 23 m.
- Never sprints in combat.
- F5 toggle with on-screen messages; setting saved in `settings.txt`.
- One-click installer and uninstaller (Steam; Epic Games Store and GOG detection). Shares UE4SS with the other
  PBZ mods and never removes UE4SS while another PBZ mod still uses it.
- Tested on Phantom Blade Zero `CL-301524_JKS-17219` (Steam) with UE4SS `v3.0.1-1185` experimental.
