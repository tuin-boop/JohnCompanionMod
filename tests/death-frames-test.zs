version "4.8"
class DeathDisplay : Actor { Default { Radius 1;Height 1;+NOGRAVITY; } States { Spawn: TNT1 A -1;Stop; } }
class DeathFramesTest : EventHandler
{
 Actor display;
 override void WorldTick(){
 let p=players[0].mo;if(!p)return;
 if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(6);players[0].cheats|=CF_GODMODE;p.angle=0;p.pitch=10;display=Actor.Spawn("DeathDisplay",p.pos+(160,0,0));}
 if(level.time==10){
 static const String prefixes[]={"YOHN","JCLS","JCMA","JR05","JC06","SWMK","JAYW","TOMH","TMPR"};
 static const String frames[]={"I","J","K","L","M","N"};
 for(int i=0;i<9;i++)for(int j=0;j<6;j++){
 String name=String.Format("%s%s0",prefixes[i],frames[j]);let tex=TexMan.CheckForTexture(name,TexMan.Type_Sprite);Vector2 size=TexMan.GetScaledSize(tex);
 Console.Printf("DEATH %s: %s size %.1f x %.1f",tex.IsValid() && size.x<120 && size.y<120?"PASS":"FAIL",name,size.x,size.y);
 }
 }
 if(level.time==15){display.sprite=display.GetSpriteIndex("JAYW");display.frame=13;}
 if(level.time==20)level.MakeScreenShot();
 }
}
