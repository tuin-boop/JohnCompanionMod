# Extra companions addon

The addon contains 14 extras: Himiko, Tina, Frier, Tuin, Kumi, Ernie, Stewie, Brian, Muscle SpongeBob, Muscle Patrick, Peter Griffin, Moneko, Knootewoot and Pope.

Load `Romero_Carmack_Companion_Control.pk3` first, then `Himiko_Companion_Addon.pk3`. Use both packages from the same current release: the v1.2.0 main package does not support Moneko, Knootewoot and Pope.

Open ESC > Extras or Options > Extra Companions. Use left/right to browse the 14 characters; browsing does not change your team. Choose Add to team or Remove from team. The panel shows both active slots and individual remove buttons. When full, the preview identifies the companion that adding will replace. The shared maximum is two, including creators, which are selected through the main Companion Control menu.

All extras use shared companion AI, weapons, K/L camp controls, independent camp cooldowns, HUD names and kill counters, and end tally portraits. They do not borrow creator dialogue or voice clips. The title map remains the five creators.

Source artwork stays at its original resolution; TEXTURES scaling sets its in-game size. Retired member IDs remain reserved, and old saved selections are filtered without renumbering remaining characters. Removing the addon hides its menu and filters absent extras out of saved teams.

Build both packages from the repository root with Python (Pillow and NumPy are needed for the addon):

```sh
python tools/build.py
python addons/Himiko/build.py
python tools/verify_packages.py
```

Outputs are in `dist/`. Do not run `import_assets.py` alone for the combined addon; it only imports Himiko.
