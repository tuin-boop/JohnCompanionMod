version "4.8"
class BanterTest : EventHandler
{
 override void WorldTick()
 {
  if(level.time==220)level.MakeScreenShot();
  if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(4);CVar.FindCVar("blnk_banter").SetBool(true);}
  if(level.time==36)
  {
   let c=NNR_CompanionBanter(EventHandler.Find("NNR_CompanionBanter"));let it=ThinkerIterator.Create("NNR_JayMarine");let j=NNR_JohnMarine(it.Next());
   Console.Printf("BANTER %s: off toggle suppresses messages",!c.Say(j,5)?"PASS":"FAIL");CVar.FindCVar("blnk_banter").SetBool(true);return;
  }
  if(level.time==37)
  {
   let c=NNR_CompanionBanter(EventHandler.Find("NNR_CompanionBanter"));let it=ThinkerIterator.Create("NNR_JayMarine");c.Say(NNR_JohnMarine(it.Next()),16);return;
  }
  if(level.time!=35)return;
  let chat=NNR_CompanionBanter(EventHandler.Find("NNR_CompanionBanter"));
  let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;NNR_JohnMarine jay;NNR_JohnMarine romero;
  while((a=NNR_JohnMarine(it.Next()))!=null){a.A_StopSound(CHAN_VOICE);a.VoiceUntil=0;if(a.IsJay())jay=a;else romero=a;}
  let cyber=Actor.Spawn("Cyberdemon",(1000,1000,0));let imp=Actor.Spawn("DoomImp",(900,1000,0));
  Console.Printf("BANTER %s: cyber and imp select different categories",chat.EnemyCategory(cyber)==5 && chat.EnemyCategory(imp)==4?"PASS":"FAIL");cyber.Destroy();imp.Destroy();
  let rocket=Actor.Spawn("FriendRocketProjectile",(900,900,100));jay.LastWeaponCategory=11;
  Console.Printf("BANTER %s: projectile takes precedence over switched gun",chat.WeaponCategory(jay,rocket)==14?"PASS":"FAIL");rocket.Destroy();
  bool spoke=chat.Say(jay,5);String first=chat.Message[0];
  Console.Printf("BANTER %s: Jay boss line displayed",spoke && chat.MessageUntil[0]==level.time+245?"PASS":"FAIL");
  Console.Printf("BANTER %s: shared cooldown blocks teammate",!chat.Say(romero,4)?"PASS":"FAIL");
  chat.NextLine[0]=0;
  Console.Printf("BANTER %s: personal cooldown blocks rapid repeat",!chat.Say(jay,5)?"PASS":"FAIL");
  chat.PersonalReady[2]=0;chat.Say(jay,5);
  Console.Printf("BANTER %s: category avoids immediate repeat",chat.Message[0]!=first?"PASS":"FAIL");
  chat.NextLine[0]=0;chat.PersonalReady[2]=0;CVar.FindCVar("blnk_banter").SetBool(false);

 }

}
