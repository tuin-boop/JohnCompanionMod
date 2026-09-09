version "4.8"
class CampCheck : EventHandler
{
 NNR_JohnMarine ro,ca;Vector3 start;Vector3 anchor;int initialMode;
 void Check(bool ok,String label){Console.Printf("CAMP2 %s: %s",ok?"PASS":"FAIL",label);}
 override void WorldTick()
 {
  let p=players[0].mo;if(!p)return;players[0].cheats |= CF_GODMODE;
  if(level.time==2){start=p.pos;CVar.FindCVar("blnk_companions").SetInt(2);CVar.FindCVar("blnk_closefollow").SetInt(0);}
  if(level.time==10)
  {
   let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null){if(a.IsCarmack())ca=a;else ro=a;}
   EventHandler.SendNetworkEvent("nnr_campro");
  }
  if(level.time==14){Check(ro.Camping && (ro.pos.XY-p.pos.XY).Length()<70,"Romero teleports and camps");anchor=ro.CampSpot;p.SetOrigin(start+(160,0,0),false);}
  if(level.time==18){EventHandler.SendNetworkEvent("nnr_campro");EventHandler.SendNetworkEvent("nnr_campca");}
  if(level.time==23){Check(ro.CampSpot==anchor && ro.Camping,"cooldown blocks repeat without releasing");Check(ca.Camping && (ca.pos.XY-p.pos.XY).Length()<70,"Carmack has independent cooldown");EventHandler.SendNetworkEvent("nnr_closefollow");}
  if(level.time==28){Check(!ro.Camping && !ca.Camping && CVar.FindCVar("blnk_closefollow").GetInt()==1,"F7 releases both and selects close");EventHandler.SendNetworkEvent("nnr_closefollow");}
  if(level.time==33)Check(CVar.FindCVar("blnk_closefollow").GetInt()==0,"second F7 selects normal");
  if(level.time==365){p.SetOrigin(start+(320,0,0),false);EventHandler.SendNetworkEvent("nnr_campro");}
  if(level.time==371)Check(ro.Camping && (ro.CampSpot.XY-anchor.XY).Length()>200 && (ro.pos.XY-p.pos.XY).Length()<70,"teleports to new camp after 10 seconds");
 }
}
