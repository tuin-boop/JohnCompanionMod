version "4.8"
class FiveBanterTest : EventHandler {
 override void WorldTick() {
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(15);CVar.FindCVar("blnk_banter").SetBool(true);}
 if(level.time!=70)return;
 let c=NNR_CompanionBanter(EventHandler.Find("NNR_CompanionBanter"));
 let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;NNR_JohnMarine tom;NNR_JohnMarine adrian;
 while((a=NNR_JohnMarine(it.Next()))!=null){if(a.IsTom())tom=a;if(a.IsAdrian())adrian=a;}
 if(!tom || !adrian){Console.Printf("FIVE FAIL: missing companions");return;}
 bool valid=true;
 for(int m=0;m<5;m++)for(int cat=0;cat<25;cat++)for(int v=0;v<2;v++)if(c.Line(m,cat,v)=="")valid=false;
 Console.Printf("FIVE %s: all 250 lines accessible",valid?"PASS":"FAIL");
 Console.Printf("FIVE %s: Tom speaks with own identity",c.Say(tom,5) && c.Speaker[0]==3?"PASS":"FAIL");
 Console.Printf("FIVE %s: shared cooldown blocks Adrian",!c.Say(adrian,4)?"PASS":"FAIL");
 c.NextLine[0]=0;
 Console.Printf("FIVE %s: Adrian speaks with own identity",c.Say(adrian,16) && c.Speaker[0]==4?"PASS":"FAIL");
 c.NextLine[0]=0;
 Console.Printf("FIVE %s: Tom personal cooldown retained",!c.Say(tom,4)?"PASS":"FAIL");
 c.PersonalReady[4]=0;String previous=c.Message[0];c.Say(adrian,16);
 Console.Printf("FIVE %s: Adrian alternates variants",previous!=c.Message[0]?"PASS":"FAIL");
 c.NextLine[0]=0;c.PersonalReady[4]=0;CVar.FindCVar("blnk_banter").SetBool(false);
 }
}
