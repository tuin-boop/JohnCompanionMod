version "4.8"
class PresentMenuTest : NNR_StyledCompanionMenu
{
 int step;
 override void Ticker(){Super.Ticker();step++;
 if(step==5){choice=18;Change(1);}
 if(step==10){Console.Printf("PRESENT %s: skin choice does not change roster",Value("blnk_tomskin")==1 && Value("blnk_companions")==10?"PASS":"FAIL");level.MakeScreenShot();}
 if(step==15)Close();
 }
}
class PresentTallyTest : NNR_JohnStatusScreen
{
 int frames;
 override void drawStats(){Super.drawStats();frames++;if(frames==20)level.MakeScreenShot();}
}
class PresentTest : EventHandler
{
 override void WorldTick(){
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(10);CVar.FindCVar("blnk_tomskin").SetInt(0);CVar.FindCVar("blnk_intermission").SetBool(true);}
 if(level.time==10)Menu.SetMenu('present_test');
 if(level.time==15){let it=ThinkerIterator.Create("NNR_TomMarine");let tom=NNR_TomMarine(it.Next());Console.Printf("PRESENT %s: live sprite and portrait update",tom && tom.sprite==tom.GetSpriteIndex("TMPR") && NNR_Team.Face(4,1)=="TMPFACE"?"PASS":"FAIL");level.MakeScreenShot();CVar.FindCVar("blnk_tomskin").SetInt(0);}
 if(level.time==20){Console.Printf("PRESENT %s: young portrait restored",NNR_Team.Face(4,1)=="TOMFACE"?"PASS":"FAIL");level.MakeScreenShot();CVar.FindCVar("blnk_tomskin").SetInt(1);}
 if(level.time==25)level.ExitLevel(0,false);
 }
}
