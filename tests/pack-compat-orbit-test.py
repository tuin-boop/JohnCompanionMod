from pathlib import Path
from zipfile import ZipFile

root = Path(__file__).resolve().parent
with ZipFile(root / 'compat-orbit-test.pk3', 'w') as archive:
    archive.write(root / 'compat-orbit-test.zs', 'ZSCRIPT')
    archive.writestr('ZMAPINFO', 'GameInfo { AddEventHandlers="CompatOrbitTest" }')

# Load after the companion PK3 and enter TITLEMAP. Repeat with TuinRPG.pk3
# loaded first. A config retaining tuin_enabled covers stale archived settings.
# Wait until both ORBIT checks print; screenshots must be enabled separately.
