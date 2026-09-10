version "4.8"
class AdrianMenuTest : NNR_StyledCompanionMenu
{
 int step;
 override void Ticker(){Super.Ticker();step++;
 if(step==3)CVar.FindCVar("blnk_companions").SetInt(15);
 if(step==6){choice=15;Change(1);}
 if(step==9)Console.Printf("ADRIAN %s: Tom replaced in full Tom/Adrian team",Value("blnk_companions")==12?"PASS":"FAIL");
 if(step==12){choice=19;Change(1);}
 if(step==15)Console.Printf("ADRIAN %s: disable Adrian preserves Romero",Value("blnk_companions")==0?"PASS":"FAIL");
 if(step==18){choice=19;Change(1);}
 if(step==21){Console.Printf("ADRIAN %s: enable Adrian",Value("blnk_companions")==12?"PASS":"FAIL");level.MakeScreenShot();}
 if(step==25)Close();
 }
}
class AdrianTest : EventHandler
{
 override void WorldTick(){
 let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;p.pitch=40;
 if(level.time>=10 && level.time<=160 && level.time%10==0)CVar.FindCVar("blnk_companions").SetInt((level.time-10)/10);
 if(level.time>=15 && level.time<=165 && level.time%10==5){
 int mode=(level.time-15)/10;int mask=0,count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
 while((a=NNR_JohnMarine(it.Next()))!=null){mask|=1<<(a.Member()-1);count++;}
 Console.Printf("ADRIAN %s: roster %d mask %d count %d",mask==NNR_Team.Mask(mode) && count<=2?"PASS":"FAIL",mode,mask,count);
 EventHandler.SendNetworkEvent("nnr_campro",1);
 }
 if(level.time>=17 && level.time<=167 && level.time%10==7){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));int mode=(level.time-17)/10;Console.Printf("ADRIAN %s: K identity",h.AimMode[0]==NNR_Team.Slot(mode,0)?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");EventHandler.SendNetworkEvent("nnr_campca",1);}
 if(level.time>=19 && level.time<=169 && level.time%10==9){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));int mode=(level.time-19)/10;Console.Printf("ADRIAN %s: L identity",h.AimMode[0]==NNR_Team.Slot(mode,1)?"PASS":"FAIL");EventHandler.SendNetworkEvent("nnr_closefollow");}
 if(level.time==175){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));let a=h.FindJohn(0,5);Console.Printf("ADRIAN %s: distinct identity and sprite",a && a.sprite==a.GetSpriteIndex("ADRN") && !a.IsCarmack()?"PASS":"FAIL");
 let tex=TexMan.CheckForTexture(NNR_Team.Face(5,1,true),TexMan.Type_Any);Console.Printf("ADRIAN %s: full-detail portrait",tex.IsValid()?"PASS":"FAIL");
 static const String frames[]={"I","J","K","L","M","N"};for(int i=0;i<6;i++){tex=TexMan.CheckForTexture(String.Format("ADRN%s0",frames[i]),TexMan.Type_Sprite);Console.Printf("ADRIAN %s: death frame %s",tex.IsValid()?"PASS":"FAIL",frames[i]);}
 level.MakeScreenShot();}
 if(level.time==180)Menu.SetMenu('adrian_test');
 }
}
