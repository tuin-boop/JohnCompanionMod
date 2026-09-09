version "4.8"
class AimCheck : EventHandler
{
 NNR_JohnMarine john;Vector3 expected,first;ui int frames;
 override void WorldTick()
 {
  let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;
  if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(0);p.angle=0;p.pitch=25;}
  if(level.time==10){let it=ThinkerIterator.Create("NNR_JohnMarine");john=NNR_JohnMarine(it.Next());EventHandler.SendNetworkEvent("nnr_campro",1);}
  if(level.time==55){Console.Printf("AIM %s: hold does not teleport",!john.Camping?"PASS":"FAIL");FLineTraceData hit;p.LineTrace(p.angle,1024,p.pitch,0,p.player.viewheight,0,0,hit);expected=hit.HitLocation+(0,0,1);EventHandler.SendNetworkEvent("nnr_campro",0);}
  if(level.time==60){Console.Printf("AIM %s: release lands at exact marker, error %.3f",john.Camping && (john.CampSpot-expected).Length()<.01?"PASS":"FAIL",(john.CampSpot-expected).Length());first=john.CampSpot;p.angle=90;EventHandler.SendNetworkEvent("nnr_campro",1);}
  if(level.time==65)EventHandler.SendNetworkEvent("nnr_campro",0);
  if(level.time==70)Console.Printf("AIM %s: cooldown blocks relocation",john.CampSpot==first?"PASS":"FAIL");
 }
 override void RenderOverlay(RenderEvent e){if(level.time>25 && level.time<50){frames++;if(frames==10)level.MakeScreenShot();}}
}
