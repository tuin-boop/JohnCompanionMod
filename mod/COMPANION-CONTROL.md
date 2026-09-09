# Romero + Carmack Companion Mod

A Doom II companion mod for UZDoom/GZDoom, featuring John Romero and John Carmack, selectable skins, voices, independent kill tallies, a companion control panel, and a torch-lit Hell titlemap.

## Play

Load `dist/Romero_Carmack_Companion_Control.pk3` with your own Doom II IWAD. Load only this companion package, not older versions alongside it. Tested with UZDoom 4.14.3. Restart the engine after updating the package.

## Controls

| Key | Action |
| --- | --- |
| F8 | Open Companion Control; also available through the Companions main-menu entry. |
| F7 | Release both camp orders and switch Normal / Close following. Press again to switch back. |
| K | Hold to aim Romero’s camp circle; release to teleport and camp. |
| L | Hold to aim Carmack’s camp circle; release to teleport and camp. |

K and L each have a separate **10-second cooldown**. Pressing them again never releases camping: after the cooldown, it relocates that John's camp. Aim at clear ground within 1024 map units. A green circle shows a valid landing; red means blocked or cooling down. The companion lands at the circle’s center. Invalid placements do not consume the cooldown. F7 also cancels a held placement. Bottom-screen messages confirm orders or show the remaining cooldown. Keys can be rebound in Customize Controls under Romero and Carmack; existing bindings take precedence over defaults.

Campers wander slightly around their individual spots and use ranged attacks without pursuing enemies. Close following also keeps them with the player during combat. Normal retains the original movement behavior. Camp spots belong to the current level.

## Skins

- Romero: Present-day, Daikatana era, John Romero 2005.
- Carmack: Young Carmack, John Carmack 2006, **SwoleMack**.

Select skins independently and choose Romero only, Carmack only, or Both. SwoleMack features short silver hair, glasses, a black T-shirt, and stronger arms. Skins include directional walking, shooting, pain, and non-bloody falling frames. Both selected skins appear in the title scene.

## Build

Python 3 is sufficient; no extra packages are required:

```sh
python tools/build.py
```

`mod/` is the complete editable source of the released PK3, including scripts, sprite definitions, graphics, and audio. The build packages it into `dist/Romero_Carmack_Companion_Control.pk3`.

## Validation

The in-engine checks in `tests/aim-test.zs` verify hold/release behavior, exact marker placement, and cooldown rejection. Previous camp checks verified teleport placement, independent cooldowns, blocked repeat presses, relocation after 10 seconds, releasing both camps, and successive F7 toggles. Earlier checks verified ranged close combat and SwoleMack in solo and duo configurations. The build also verifies archive integrity.

## Assets and attribution

This project extends the supplied John Romero companion mod and preserves its bundled credits and resources in `mod/`. Sprite variants were generated using supplied reference photographs and then extracted and registered as Doom sprites. The SwoleMack generation prompt is in `art/SwoleMack-generation-prompt.txt`. The companion panel uses TINYBABY lettering and a blue/cyan style adapted from the Doom Cleanup Sim project. Carmack dialogue uses the interview clips supplied for this mod. Doom II game data and engine binaries are not included. No blanket license is asserted over third-party assets.

If updating from the old instant camp bindings, rebind the two camp commands in Customize Controls to enable hold/release.

## TuinDoomRPG compatibility

Load `TuinRPG.pk3` first, followed by `Romero_Carmack_Companion_Control.pk3`. A green **TUIN RPG DETECTED - COMPATIBILITY ACTIVE** message confirms detection. The companion titlemap skips the RPG's per-level gameplay/HUD handlers so the mandatory class chooser does not open in the decorative title scene. The engine recreates those handlers normally on a real map; class selection and gameplay remain active. No TuinDoomRPG files are modified. Verified with the supplied TuinRPG package in UZDoom 4.14.3.

Companions scan for visible hostile monsters within 2048 map units once per second, speeding up to every 8 tics after five seconds without firing. Camping requests an immediate scan. More than 15 visible hostiles increases heavy ranged weapon selection for both weapon sets; camping and close-follow movement limits still apply.
