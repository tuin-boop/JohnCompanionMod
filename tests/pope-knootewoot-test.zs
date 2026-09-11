version "4.8"
class PopeExtrasTest : EventHandler {
 override void WorldTick(){
  if(level.time==2)CVar.FindCVar("blnk_companions").SetInt(256+8192+16384);
  if(level.time==35 || level.time==70 || level.time==105){
   int mask=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null)mask|=1<<(a.Member()-1);
   int expected=level.time==35?24576:level.time==70?32832:1572864;
   Console.Printf("POPE %s: spawned pair %d",mask==expected?"PASS":"FAIL",mask);
   if(level.time==35)CVar.FindCVar("blnk_companions").SetInt(256+32768+64);
   else if(level.time==70)CVar.FindCVar("blnk_companions").SetInt(256+1572864);
   else Menu.SetMenu('HimikoOptions');
  }
 }
}
class PopeMenuCheck : NNR_HimikoMenu {
 int ticks;
 override void Ticker(){Super.Ticker();ticks++;
  if(ticks==2){int mask=0;for(int i=0;i<14;i++){mask|=1<<(Current()-1);Browse(1);}Console.Printf("POPE %s: carousel",mask==2095968?"PASS":"FAIL");Browse(13);}
 }
}
