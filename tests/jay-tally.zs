version "4.8"
class JayTally : NNR_JohnStatusScreen
{
 int frames;
 override void drawStats(){Super.drawStats();frames++;if(frames==20)level.MakeScreenShot();}
}
class JayExit : EventHandler
{
 override void WorldTick()
 {
  if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(5);CVar.FindCVar("blnk_jay").SetBool(true);CVar.FindCVar("blnk_intermission").SetBool(true);}
  if(level.time==35)level.ExitLevel(0,false);
 }
}
