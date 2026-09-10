version "4.8"
class ToggleTestMenu : NNR_StyledCompanionMenu
{
 int steps;
 override void Ticker()
 {
  Super.Ticker();steps++;
  if(steps==5)CVar.FindCVar("blnk_companions").SetInt(2);
  if(steps==10){choice=15;Change(1);}
  if(steps==20){Console.Printf("TOGGLE %s: Romero off leaves Carmack",Value("blnk_companions")==1?"PASS":"FAIL");choice=15;Change(1);}
  if(steps==30){Console.Printf("TOGGLE %s: Romero on restores pair",Value("blnk_companions")==2?"PASS":"FAIL");choice=13;Change(1);}
  if(steps==40){Console.Printf("TOGGLE %s: Jay replaces Romero with warning",Value("blnk_companions")==5 && teamNotice=="LIMIT 2: ROMERO OFF, JAY ON"?"PASS":"FAIL");level.MakeScreenShot();}
  if(steps==50){choice=16;Change(1);}
  if(steps==60){Console.Printf("TOGGLE %s: Carmack off leaves Jay",Value("blnk_companions")==3?"PASS":"FAIL");choice=13;Change(1);}
  if(steps==70){Console.Printf("TOGGLE %s: last companion off gives none",Value("blnk_companions")==6 && !Value("blnk_jay")?"PASS":"FAIL");choice=16;Change(1);}
  if(steps==80){Console.Printf("TOGGLE %s: Carmack activates from none",Value("blnk_companions")==1?"PASS":"FAIL");choice=16;Change(1);}
  if(steps==90)Close();
 }
}
class ToggleTestOpen : EventHandler
{
 override void WorldTick()
 {
  if(level.time==10)Menu.SetMenu('toggle_test');
  if(level.time==20)
  {
   let it=ThinkerIterator.Create("NNR_JohnMarine");Console.Printf("TOGGLE %s: none removes all live companions",it.Next()==null?"PASS":"FAIL");
  }
 }
}
