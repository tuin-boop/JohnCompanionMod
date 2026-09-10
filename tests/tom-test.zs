version "4.8"
class TomMenuTest : NNR_StyledCompanionMenu
{
 int step;
 override void Ticker(){Super.Ticker();step++;
 if(step==5){CVar.FindCVar("blnk_companions").SetInt(2);}
 if(step==10){choice=17;Change(1);}
 if(step==15){Console.Printf("TOM %s: third activation preserves two",Value("blnk_companions")==9?"PASS":"FAIL");level.MakeScreenShot();}
 if(step==25)Close();
 }
}
class TomTest : EventHandler
{
 override void WorldTick(){
 let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;p.pitch=40;
 if(level.time>=10 && level.time<=110 && level.time%10==0)CVar.FindCVar("blnk_companions").SetInt((level.time-10)/10);
 if(level.time>=15 && level.time<=115 && level.time%10==5){
 int mode=(level.time-15)/10;int mask=0,count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
 while((a=NNR_JohnMarine(it.Next()))!=null){mask|=1<<(a.Member()-1);count++;}
 Console.Printf("TOM %s: roster %d mask %d count %d",mask==NNR_Team.Mask(mode) && count<=2?"PASS":"FAIL",mode,mask,count);
 EventHandler.SendNetworkEvent("nnr_campro",1);
 }
 if(level.time>=17 && level.time<=117 && level.time%10==7){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));int mode=(level.time-17)/10;Console.Printf("TOM %s: K targets first selected identity",h.AimMode[0]==NNR_Team.Slot(mode,0)?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");EventHandler.SendNetworkEvent("nnr_campca",1);}
 if(level.time>=19 && level.time<=119 && level.time%10==9){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));int mode=(level.time-19)/10;Console.Printf("TOM %s: L targets second selected identity",h.AimMode[0]==NNR_Team.Slot(mode,1)?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");}
 if(level.time==125){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));let tom=h.FindJohn(0,4);Console.Printf("TOM %s: Tom sprite and distinct identity",tom && tom.sprite==tom.GetSpriteIndex("TOMH") && !tom.IsJay() && !tom.IsCarmack()?"PASS":"FAIL");level.MakeScreenShot();}
 if(level.time==130)Menu.SetMenu('tom_test');
 }
}
