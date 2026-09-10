from pathlib import Path
from zipfile import ZipFile
root=Path(__file__).resolve().parent
with ZipFile(root/'adrian-present-test.pk3','w') as z:
 z.write(root/'adrian-present-test.zs','ZSCRIPT')
 z.writestr('ZMAPINFO','GameInfo { AddEventHandlers="AdrianPresentTest" }')
 z.writestr('MENUDEF','OptionMenu adrian_present_test { Class "AdrianPresentMenuTest" Title "Test" }')
with ZipFile(root/'title-sway-test.pk3','w') as z:
 z.writestr('ZSCRIPT','''version "4.8"
class TitleSwayTest : EventHandler {
 double right;
 override void WorldTick(){
 if(level.time==2)CVar.FindCVar("blnk_adrianskin").SetInt(1);
 let h=NNR_HellTitle(EventHandler.Find("NNR_HellTitle"));
 if(level.time==300){right=h.camera.pos.x;Console.Printf("SWAY %s: right endpoint",right>27?"PASS":"FAIL");level.MakeScreenShot();}
 if(level.time==900){Console.Printf("SWAY %s: left endpoint",h.camera.pos.x < -27 && right>27?"PASS":"FAIL");Console.Printf("SWAY %s: Adrian title skin",h.lineup[4].sprite==h.lineup[4].GetSpriteIndex("ADRP")?"PASS":"FAIL");level.MakeScreenShot();}
 }
}''')
 z.writestr('ZMAPINFO','GameInfo { AddEventHandlers="TitleSwayTest" }')
