version "4.8"
class ExtrasTest : EventHandler {
 override void WorldTick(){
  if(level.time==2){
   bool ok=true;
   for(int a=1;a<=21;a++)for(int b=a;b<=21;b++){
    int mask=(1<<(a-1))|(1<<(b-1));
    if(NNR_Team.Mask(NNR_Team.Mode(mask))!=(mask&~(128|1024)))ok=false;
   }
   Console.Printf("EXTRAS %s: all solo/pair selections and retired IDs",ok?"PASS":"FAIL");
   ok=true;for(int m=6;m<=21;m++)if(m!=8 && m!=11 && !TexMan.CheckForTexture(NNR_Team.Face(m,1),TexMan.Type_Any).isValid())ok=false;
   Console.Printf("EXTRAS %s: fourteen HUD portraits",ok?"PASS":"FAIL");
   String retired="NNR_KarinMarine";String retired2="NNR_EstherMarine";
   Console.Printf("EXTRAS %s: removed actors absent",(class<Actor>)(retired)==null && (class<Actor>)(retired2)==null?"PASS":"FAIL");
   CVar.FindCVar("blnk_companions").SetInt(256+128+2048);
  }
  if(level.time==35){
   int mask=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null)mask|=1<<(a.Member()-1);
   Console.Printf("EXTRAS %s: old saved pair keeps active partner",mask==2048?"PASS":"FAIL");
   CVar.FindCVar("blnk_companions").SetInt(256+1572864);
  }
  if(level.time==70){
   int mask=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
   while((a=NNR_JohnMarine(it.Next()))!=null)mask|=1<<(a.Member()-1);
   Console.Printf("EXTRAS %s: current main spawns Knootewoot and Pope",mask==1572864?"PASS":"FAIL");
   Menu.SetMenu('HimikoOptions');
  }
 }
}
class ExtrasMenuCheck : NNR_HimikoMenu {
 int ticks;
 override void Ticker(){Super.Ticker();ticks++;
  if(ticks==2){int mask=0;for(int i=0;i<14;i++){mask|=1<<(Current()-1);Browse(1);}Console.Printf("EXTRAS %s: fourteen-member carousel",mask==2095968?"PASS":"FAIL");}
 }
}
