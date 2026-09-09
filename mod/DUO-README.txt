# Romero and Young Carmack

Load Romero_Carmack_Duo_Companion.pk3 alone, replacing the older companion package.

Options > Friend Options > Romero and Carmack together enables both companions. Choose Romero's modern or Daikatana-era appearance with Romero skin when together. With the pair option off, Solo companion skin chooses one companion as before. Changes apply during play.

Both companions have separate kill counts on the top-right HUD and end-level tally. The supplied left, center and right Carmack portraits animate his eyes. Romero can speak and show facts when present; Carmack remains free of Romero voice lines. Solo Carmack suppresses the facts and remarks as before.

The companion manager checks each player's companions, keeps one of each selected role, and removes duplicates when the selection changes. Counters are tracked by the attacking companion, including projectiles, and reset each new map. Existing friendly-fire protection covers both roles.

Build with tools/build_duo_companion.py using Python and Pillow. It extends JohnRomero_Carmack_Companion_Skins.pk3; supplied portrait originals are saved in this directory.

Verified in UZDoom 4.14.3: two distinct identities, separate body sprites, silent Carmack, direct and projectile kill attribution, switching between solo and duo, and duplicate prevention. The end-level test recorded Romero 1 / Carmack 2 and both portraits were visually checked on the tally. The portrait images retain their full source resolution and are scaled by the engine.
