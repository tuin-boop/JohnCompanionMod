# All companion skins and Carmack recordings

Load Romero_Carmack_Companion_All_Skins.pk3 alone in place of older companion PK3s.

Options > Friend Options includes three Romero body skins (present day, Daikatana era, John Romero 2005) and two Carmack body skins (Young Carmack, John Carmack 2006). Solo companion skin selects one; with Romero and Carmack together enabled, use the two separate skin selectors for the pair.

All five full interview recordings play for either Carmack skin, with a one-minute initial grace period, a three-minute default pause after each clip, and no immediate repeats or overlapping companion speech. Carmack interview voice and the pause duration are adjustable in this menu. Tips remain suppressed for solo Carmack.

Both new body skins include directional walking, aiming, firing, pain, and bloodless collapse/revival. Existing HUD/tally portrait artwork is retained; the new 2005/2006 references are used for body skins. Both companions keep separate kill counts in duo mode.

Build order: tools/build_voice_2005.py then tools/build_2006_skin.py. Generation prompts, purple source sheets and transparent sheets are saved beside the relevant skin files. Original interview WAV files remain unchanged; the mod uses mono Ogg Vorbis copies.

Verified in UZDoom 4.14.3: both new skins in solo and duo modes; all five sound assets decode and start playback; initial grace period, cooldown calculation, repeat prevention, mute and companion speech exclusion. The menu and transparent sheets were visually inspected. Test fixtures are excluded from the release package.
