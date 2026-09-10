version "4.8"
class ErnieTest : EventHandler {
 override void WorldTick(){
 if(level.time==2){bool ok=true;for(int mask=0;mask<8192;mask++){int n=0;for(int b=0;b<13;b++)if(mask&(1<<b))n++;if(n<=2 && NNR_Team.Mask(NNR_Team.Mode(mask))!=mask)ok=false;}Console.Printf("ERNIE %s: all solo and pair selections",ok?"PASS":"FAIL");CVar.FindCVar("blnk_companions").SetInt(NNR_Team.Mode(5120));}
 if(level.time==35){int mask=0,count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;while((a=NNR_JohnMarine(it.Next()))!=null){mask|=1<<(a.Member()-1);count++;}Console.Printf("ERNIE %s: Esther and Ernie spawn",count==2 && mask==5120?"PASS":"FAIL");Console.Printf("ERNIE %s: portrait and name",NNR_Team.Name(13)=="ERNIE" && TexMan.CheckForTexture(NNR_Team.Face(13,1),TexMan.Type_Any).isValid()?"PASS":"FAIL");Menu.SetMenu('HimikoOptions');}
 }
}
class ErnieMenuCheck : NNR_HimikoMenu {int ticks;override void Ticker(){Super.Ticker();ticks++;if(ticks==2)Browse(-1);if(ticks==10){Console.Printf("ERNIE %s: eighth carousel entry",Current()==13?"PASS":"FAIL");level.MakeScreenShot();}}}
