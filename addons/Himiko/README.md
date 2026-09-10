# Extra companions addon

Load the updated main mod first, then Himiko_Companion_Addon.pk3. This existing filename now contains Himiko, Tina, Karin, Frier, Tuin, Esther, Kumi and Ernie. Open ESC > Extras or Options > Extra Companions.

Use left/right arrows to browse the eight characters. Browsing never changes the team. Click Add to team or Remove from team, or select the button and press Enter. The right panel shows the two active slots with portraits and individual remove buttons. When full, the preview tells you which companion adding will replace. The maximum remains two, including creators. Creator companions can be added from the main Companion Control menu.

All eight use shared AI, weapons, K/L camp controls, independent camp cooldowns, HUD names and kill counters, and end tally portraits. They do not borrow creator dialogue or voice clips. Tina uses the supplied center and side portraits. Frier and Esther have generated portraits matching their references. Tuin uses the supplied portrait. Karin currently uses a temporary portrait extracted from her idle sprite. Karin, Frier, Tuin, Esther, Kumi and Ernie each have a seven-row source sheet that reuses a walking pose for the third walk beat.

Requires the updated main PK3 shipped alongside this addon. Removing the addon hides its menu and filters absent characters out of saved teams. The title map remains the five creators.

Build with Python, Pillow and NumPy: run `python addons/Himiko/build.py` from the repository root. This imports Himiko, then the other seven extras, and packages all eight. Do not use import_assets.py alone for the combined addon.
