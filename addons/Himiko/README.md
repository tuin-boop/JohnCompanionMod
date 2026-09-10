# Extra companions addon

Load the updated main mod first, then Himiko_Companion_Addon.pk3. This existing filename now contains Himiko, Tina and Karin. Open ESC > Extras or Options > Extra Companions.

Use the character arrows to browse all three animated cards. Turn On/Off changes that character while preserving the other active companion. Enabling a third replaces the first active member and displays a warning. The partner arrows choose a pair with any creator or extra character; maximum two total. Tina + Karin is supported.

All three use shared AI, weapons, K/L camp controls, independent camp cooldowns, HUD names and kill counters, and end tally portraits. They do not borrow creator dialogue or voice clips. Tina uses the supplied center and side portraits. Karin currently uses a temporary portrait extracted from her idle sprite. Her seven-row source sheet reuses a walking pose for the third walk beat.

Requires the updated main PK3 shipped alongside this addon. Removing the addon hides its menu and filters absent characters out of saved teams. The title map remains the five creators.

Build with Python, Pillow and NumPy: run `python addons/Himiko/build.py` from the repository root. This imports Himiko, then Tina and Karin, and packages all three. Do not use import_assets.py alone for the combined addon.
