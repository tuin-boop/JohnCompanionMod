version "4.8"
class AdrianPresentMenuTest : NNR_StyledCompanionMenu {
 int t;
 override void Ticker(){Super.Ticker();t++;
 if(t==3){choice=20;Change(1);}
 if(t==6)Console.Printf("PRESENT %s: skin button switches to young",Value("blnk_adrianskin")==0?"PASS":"FAIL");
 if(t==9){choice=20;Change(1);}
 if(t==12){Console.Printf("PRESENT %s: skin button switches to present",Value("blnk_adrianskin")==1?"PASS":"FAIL");level.MakeScreenShot();}
 if(t==18)Close();
 }
}
class AdrianPresentTest : EventHandler {
 override void WorldTick(){
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(11);CVar.FindCVar("blnk_adrianskin").SetInt(1);}
 if(level.time==10){let h=NNR_FollowNotice(EventHandler.Find("NNR_FollowNotice"));let a=h.FindJohn(0,5);
 Console.Printf("PRESENT %s: gameplay skin",a && a.sprite==a.GetSpriteIndex("ADRP")?"PASS":"FAIL");
 static const String frames[]={"A","B","C","D","E","F","G","I","J","K","L","M","N"};
 for(int i=0;i<13;i++){let tex=TexMan.CheckForTexture(String.Format("ADRP%s%d",frames[i],i<7?1:0),TexMan.Type_Sprite);Console.Printf("PRESENT %s: %s",tex.IsValid()?"PASS":"FAIL",frames[i]);}
 }
 if(level.time==15)Menu.SetMenu('adrian_present_test');
 }
}
