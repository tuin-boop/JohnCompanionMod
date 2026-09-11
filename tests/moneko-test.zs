version "4.8"
class MonekoExtrasTest : EventHandler {
 override void WorldTick(){
  if(level.time==2)CVar.FindCVar("blnk_companions").SetInt(256+8192+16384);
  if(level.time==35 || level.time==70 || level.time==105){
   int mask=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null)mask|=1<<(a.Member()-1);
   int expected=level.time==35?24576:level.time==70?32832:393216;
   Console.Printf("MONEKO %s: spawned pair %d",mask==expected?"PASS":"FAIL",mask);
   if(level.time==35)CVar.FindCVar("blnk_companions").SetInt(256+32768+64);
   else if(level.time==70)CVar.FindCVar("blnk_companions").SetInt(256+393216);
   else Menu.SetMenu('HimikoOptions');
  }
 }
}
class MonekoMenuCheck : NNR_HimikoMenu {
 int ticks;
 override void Ticker(){Super.Ticker();ticks++;
  if(ticks==2){int mask=0;for(int i=0;i<12;i++){mask|=1<<(Current()-1);Browse(1);}Console.Printf("MONEKO %s: carousel",mask==523104?"PASS":"FAIL");Browse(11);}
 }
}
