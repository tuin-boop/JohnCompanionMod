version "4.8"
class JayDummy : Actor { Default { Monster;Health 100000;Radius 16;Height 56;-COUNTKILL; } States { Spawn: TROO A -1;Stop; } }
class JayTest : EventHandler
{
 NNR_JohnMarine jay;Vector3 anchor;ui int menuFrames;
 override void WorldTick()
 {
  let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;
  if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(4);CVar.FindCVar("blnk_jay").SetBool(true);p.angle=0;p.pitch=25;}
  if(level.time==10)
  {
   let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;int count=0;
   while((a=NNR_JohnMarine(it.Next()))!=null){count++;if(a.IsJay())jay=a;}
   Console.Printf("JAY %s: two companions, distinct Jay identity",count==2 && jay && !jay.IsCarmack()?"PASS":"FAIL");
   Console.Printf("JAY %s: sprite and no borrowed voice",jay.sprite==jay.GetSpriteIndex("JAYW") && !jay.IsActorPlayingSound(CHAN_VOICE)?"PASS":"FAIL");
   EventHandler.SendNetworkEvent("nnr_campjay",1);
  }
  if(level.time==20){Console.Printf("JAY %s: hold does not camp",!jay.Camping?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_campjay",0);}
  if(level.time==25)
  {
   anchor=jay.CampSpot;
   Console.Printf("JAY %s: release camps Jay",jay.Camping?"PASS":"FAIL");
   p.angle=90;EventHandler.SendNetworkEvent("nnr_campjay",1);
   let victim=Actor.Spawn("JayDummy",p.pos+(240,240,0));victim.DamageMobj(jay,jay,100001,'None');
   Console.Printf("JAY %s: independent kill credit",p.CountInv("NNR_JayLevelKillCounter")==1 && p.CountInv("NNR_JohnLevelKillCounter")==0 && p.CountInv("NNR_CarmackLevelKillCounter")==0?"PASS":"FAIL");
  }
  if(level.time==30)EventHandler.SendNetworkEvent("nnr_campjay",0);
  if(level.time==35){Console.Printf("JAY %s: cooldown prevents relocation",jay.CampSpot==anchor?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");}
  if(level.time==40){Console.Printf("JAY %s: F7 releases Jay",!jay.Camping?"PASS":"FAIL");CVar.FindCVar("blnk_companions").SetInt(0);}
  if(level.time==45){let it=ThinkerIterator.Create("NNR_JayMarine");Console.Printf("JAY %s: toggle removes Jay",it.Next()==null?"PASS":"FAIL");CVar.FindCVar("blnk_companions").SetInt(4);}
  if(level.time>=60 && level.time<120 && level.time%10==0)CVar.FindCVar("blnk_companions").SetInt((level.time-60)/10);
  if(level.time>=65 && level.time<125 && level.time%10==5)
  {
   int mode=(level.time-65)/10;int count=0;int r=0;int c=0;int j=0;
   let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null){count++;if(a.IsJay())j++;else if(a.IsCarmack())c++;else r++;}
   bool ok=count<=2 && r==int(mode==0 || mode==2 || mode==4) && c==int(mode==1 || mode==2 || mode==5) && j==int(mode>=3);
   Console.Printf("JAY %s: team mode %d has correct roster (%d members)",ok?"PASS":"FAIL",mode,count);
  }
  if(level.time==140){level.MakeScreenShot();Menu.SetMenu('blnk_options');}
 }
 override void RenderOverlay(RenderEvent e)
 {
  if(Menu.GetCurrentMenu() is "NNR_StyledCompanionMenu"){menuFrames++;if(menuFrames==20)level.MakeScreenShot();}
 }
}
