version "4.8"
class HimikoTest : EventHandler {
 override void WorldTick(){
 if(level.time==2)CVar.FindCVar("blnk_companions").SetInt(21);
 if(level.time==35){
 bool ok=true;for(int mode=16;mode<=21;mode++)if(NNR_Team.Mode(NNR_Team.Mask(mode))!=mode)ok=false;
 Console.Printf("HIMIKO %s: all six addon teams roundtrip",ok?"PASS":"FAIL");
 let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;int count=0;bool found=false;
 while((a=NNR_JohnMarine(it.Next()))!=null){count++;if(a.Member()==6){found=a.sprite==a.GetSpriteIndex("HIMK");}}
 Console.Printf("HIMIKO %s: two companions including Himiko",count==2 && found?"PASS":"FAIL");
 Console.Printf("HIMIKO %s: name portrait and camp slot",NNR_Team.Name(6)=="HIMIKO" && NNR_Team.Face(6,1)=="HIKFACE" && NNR_Team.Slot(21,1)==6?"PASS":"FAIL");
 CVar.FindCVar("blnk_companions").SetInt(16);
 }
 if(level.time==70){
 let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;int count=0;while((a=NNR_JohnMarine(it.Next()))!=null)count++;
 Console.Printf("HIMIKO %s: solo selection reconciled",count==1?"PASS":"FAIL");
 level.MakeScreenShot();CVar.FindCVar("blnk_companions").SetInt(2);
 }
 if(level.time==105){let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;int count=0;bool found=false;while((a=NNR_JohnMarine(it.Next()))!=null){count++;if(a.Member()==6)found=true;}Console.Printf("HIMIKO %s: base roster restored",count==2 && !found?"PASS":"FAIL");Menu.SetMenu('HimikoOptions');}
 }
}

class HimikoMenuCheck : NNR_HimikoMenu { int ticks; override void Ticker(){Super.Ticker();ticks++;if(ticks==20)level.MakeScreenShot();} }
