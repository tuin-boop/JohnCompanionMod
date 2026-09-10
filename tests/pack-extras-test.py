from pathlib import Path
from zipfile import ZipFile
root=Path(__file__).resolve().parent
with ZipFile(root/'extras-test.pk3','w') as z:
 z.write(root/'extras-test.zs','ZSCRIPT')
 z.writestr('ZMAPINFO','GameInfo { AddEventHandlers="ExtrasTest" }')
 z.writestr('MENUDEF','OptionMenu "HimikoOptions" { Class "ExtrasMenuCheck" }')
