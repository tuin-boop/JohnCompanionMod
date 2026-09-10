version "4.8"
class TomTallyTest : NNR_JohnStatusScreen
{
 int frames;
 override void drawStats(){Super.drawStats();frames++;if(frames==20)level.MakeScreenShot();}
}
class TomVictim : Actor { Default { Monster;Health 10;Radius 16;Height 56; } States { Spawn: TROO A -1;Stop; } }
class TomCampTest : EventHandler
{
 Vector3 spot;
 override void WorldTick(){
 let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;p.pitch=40;
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(10);CVar.FindCVar("blnk_intermission").SetBool(true);}
 let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));
 if(level.time==10)EventHandler.SendNetworkEvent("nnr_campca",1);
 if(level.time==15)EventHandler.SendNetworkEvent("nnr_campca",0);
 if(level.time==20){let tom=h.FindJohn(0,4);spot=tom.CampSpot;Console.Printf("TOM %s: L release places Tom with named notice",tom.Camping && h.notice=="TOM HALL: CAMP SET - 10 SEC COOLDOWN"?"PASS":"FAIL");p.angle=90;EventHandler.SendNetworkEvent("nnr_campca",1);}
 if(level.time==25)EventHandler.SendNetworkEvent("nnr_campca",0);
 if(level.time==30){let tom=h.FindJohn(0,4);Console.Printf("TOM %s: cooldown prevents relocation",tom.CampSpot==spot?"PASS":"FAIL");let v=Actor.Spawn("TomVictim",p.pos+(300,0,0));v.DamageMobj(tom,tom,100,'None');Console.Printf("TOM %s: distinct kill counter",p.CountInv("NNR_TomLevelKillCounter")==1 && p.CountInv("NNR_JayLevelKillCounter")==0?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");}
 if(level.time==35){let tom=h.FindJohn(0,4);Console.Printf("TOM %s: F7 releases camp",!tom.Camping?"PASS":"FAIL");}
 if(level.time==40)level.ExitLevel(0,false);
 }
}
