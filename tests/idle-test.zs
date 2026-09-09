version "4.8"
class IdleDummy : Actor
{
 Default { Monster;Health 100000;Radius 16;Height 56;-COUNTKILL; }
 States { Spawn: TROO A -1;Stop; }
}
class IdleCheck : EventHandler
{
 NNR_JohnMarine john;bool stable,moved,attack;Actor dummy;
 override void WorldTick()
 {
  let p=players[0].mo;if(!p)return;players[0].cheats |= CF_GODMODE;
  if(level.time==2){CVar.FindCVar("blnk_companions").SetInt(0);stable=true;}
  if(level.time==10)
  {
   let it=ThinkerIterator.Create("NNR_JohnMarine");john=NNR_JohnMarine(it.Next());
   john.SetOrigin(p.pos+(-96,64,0),false);john.Camping=true;john.CampSpot=john.pos;john.CampGoal=john.pos.XY;john.NextCampWander=99999;john.target=null;john.SetStateLabel("See");
  }
  if(level.time>15 && level.time<70 && john.frame!=0)stable=false;
  if(level.time==70){Console.Printf("IDLE %s: stationary walking pose stays still",stable?"PASS":"FAIL");john.CampGoal=john.pos.XY+(-120,0);}
  if(level.time>70 && level.time<100 && john.frame>0 && john.frame<4)moved=true;
  if(level.time==110)
  {
   Console.Printf("IDLE %s: moving walk animation resumes",moved?"PASS":"FAIL");
   dummy=Actor.Spawn("IdleDummy",p.pos+(240,64,0));john.target=dummy;john.SetStateLabel("Shotgun");
  }
  if(level.time>110 && level.time<180 && (john.frame==4 || john.frame==5))attack=true;
  if(level.time==180)Console.Printf("IDLE %s: firing animation and damage preserved",attack && dummy.health<100000?"PASS":"FAIL");
 }
}
