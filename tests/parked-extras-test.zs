version "4.8"
class ParkedExtrasTest : EventHandler {
 override void WorldTick(){
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(256+128+2048);}
 if(level.time==35){int mask=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;while((a=NNR_JohnMarine(it.Next()))!=null)mask|=1<<(a.Member()-1);Console.Printf("PARKED %s: old Karin pair keeps Kumi",mask==2048?"PASS":"FAIL");Console.Printf("PARKED %s: Esther filtered from old pair",NNR_Team.Mask(256+1024+512)==512?"PASS":"FAIL");Console.Printf("PARKED %s: both disabled means empty",NNR_Team.Mask(256+128+1024)==0?"PASS":"FAIL");Menu.SetMenu('HimikoOptions');}
 }
}
class ParkedMenuCheck : NNR_HimikoMenu {int ticks;override void Ticker(){Super.Ticker();ticks++;if(ticks==2){int mask=0;for(int i=0;i<6;i++){mask|=1<<(Current()-1);Browse(1);}Console.Printf("PARKED %s: six remaining carousel characters",mask==(32|64|256|512|2048|4096)?"PASS":"FAIL");}}}
