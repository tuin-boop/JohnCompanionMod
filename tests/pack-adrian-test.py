from pathlib import Path
from zipfile import ZipFile
root=Path(__file__).resolve().parent
with ZipFile(root/'adrian-test.pk3','w') as z:
 z.write(root/'adrian-test.zs','ZSCRIPT')
 z.writestr('ZMAPINFO','GameInfo { AddEventHandlers="AdrianTest" }')
 z.writestr('MENUDEF','OptionMenu adrian_test { Class "AdrianMenuTest" Title "Test" }')
with ZipFile(root/'adrian-title-test.pk3','w') as z:
 z.writestr('ZSCRIPT','''version "4.8"
class AdrianTitleTest : EventHandler {
 override void WorldTick(){if(level.time==20){CVar.FindCVar("blnk_companions").SetInt(15);}
 if(level.time==35){let h=NNR_HellTitle(EventHandler.Find("NNR_HellTitle"));int count=0;for(int i=0;i<5;i++)if(h.lineup[i] && !h.lineup[i].bINVISIBLE)count++;Console.Printf("TITLE %s: five visible",count==5?"PASS":"FAIL");level.MakeScreenShot();}
 }
}''')
 z.writestr('ZMAPINFO','GameInfo { AddEventHandlers="AdrianTitleTest" }')
