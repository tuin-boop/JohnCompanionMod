version "4.8"
class KumiTest : EventHandler {
 override void WorldTick(){
 if(level.time==2){bool ok=true;for(int mask=0;mask<4096;mask++){int n=0;for(int b=0;b<12;b++)if(mask&(1<<b))n++;if(n<=2 && NNR_Team.Mask(NNR_Team.Mode(mask))!=mask)ok=false;}Console.Printf("KUMI %s: all solo and pair selections",ok?"PASS":"FAIL");CVar.FindCVar("blnk_companions").SetInt(NNR_Team.Mode(3072));}
 if(level.time==35){int mask=0,count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;while((a=NNR_JohnMarine(it.Next()))!=null){mask|=1<<(a.Member()-1);count++;}Console.Printf("KUMI %s: Esther and Kumi spawn",count==2 && mask==3072?"PASS":"FAIL");Console.Printf("KUMI %s: portrait and name",NNR_Team.Name(12)=="KUMI" && TexMan.CheckForTexture(NNR_Team.Face(12,1),TexMan.Type_Any).isValid()?"PASS":"FAIL");Menu.SetMenu('HimikoOptions');}
 }
}
class KumiMenuCheck : NNR_HimikoMenu {int ticks;override void Ticker(){Super.Ticker();ticks++;if(ticks==2)Browse(-1);if(ticks==10){Console.Printf("KUMI %s: seventh carousel entry",Current()==12?"PASS":"FAIL");level.MakeScreenShot();}}}
