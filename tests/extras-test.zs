version "4.8"
class ExtrasTest : EventHandler {
 override void WorldTick(){
 if(level.time==2){
 bool ok=true;for(int mask=0;mask<256;mask++){int n=0;for(int b=0;b<8;b++)if(mask&(1<<b))n++;if(n<=2 && NNR_Team.Mask(NNR_Team.Mode(mask))!=mask)ok=false;}
 Console.Printf("EXTRAS %s: all zero, solo and pair selections roundtrip",ok?"PASS":"FAIL");
 CVar.FindCVar("blnk_companions").SetInt(NNR_Team.Mode(192));
 }
 if(level.time==35){
 int mask=0,count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;
 while((a=NNR_JohnMarine(it.Next()))!=null){mask|=1<<(a.Member()-1);count++;}
 Console.Printf("EXTRAS %s: Tina and Karin spawned together",count==2 && mask==192?"PASS":"FAIL");
 Console.Printf("EXTRAS %s: camp slots and independent kill counters",NNR_Team.Slot(NNR_Team.Mode(192),0)==7 && NNR_Team.Slot(NNR_Team.Mode(192),1)==8 && NNR_Team.Counter(7)!=NNR_Team.Counter(8)?"PASS":"FAIL");
 bool ok=true;for(int m=6;m<=8;m++)if(!TexMan.CheckForTexture(NNR_Team.Face(m,1),TexMan.Type_Any).isValid())ok=false;
 Console.Printf("EXTRAS %s: all extra HUD textures available",ok?"PASS":"FAIL");
 level.MakeScreenShot();CVar.FindCVar("blnk_companions").SetInt(NNR_Team.Mode(128));
 }
 if(level.time==70){
 int count=0;let it=ThinkerIterator.Create("NNR_JohnMarine");NNR_JohnMarine a;while((a=NNR_JohnMarine(it.Next()))!=null)count++;
 Console.Printf("EXTRAS %s: disabling Tina leaves one companion",count==1?"PASS":"FAIL");
 Menu.SetMenu('HimikoOptions');
 }
 }
}
class ExtrasMenuCheck : NNR_HimikoMenu {
 int ticks;
 override void Ticker(){Super.Ticker();ticks++;
 if(ticks==2){choice=2;Apply(1);}
 if(ticks==3){choice=0;Apply(1);}
 if(ticks==4){choice=2;Apply(1);}
 if(ticks==5){choice=2;Apply(1);choice=0;Apply(1);}
 if(ticks==10){int mask=NNR_Team.Mask(Value("blnk_companions"));Console.Printf("EXTRAS %s: carousel enable replaces third companion",mask==160?"PASS":"FAIL");level.MakeScreenShot();}
 }
}
