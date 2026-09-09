version "4.8"
class ThreatDummy : Actor
{
 Default { Monster;Health 1000000;Radius 12;Height 56;-COUNTKILL; }
 States { Spawn: TROO A -1;Stop; }
}
class ThreatCheck : EventHandler
{
 NNR_JohnMarine john;Actor first;Vector3 anchor;
 override void WorldTick()
 {
  let p=players[0].mo;if(!p)return;players[0].cheats|=CF_GODMODE;
  if(level.time==2)CVar.FindCVar("blnk_companions").SetInt(0);
  if(level.time==10)
  {
   let it=ThinkerIterator.Create("NNR_JohnMarine");john=NNR_JohnMarine(it.Next());
   john.SetOrigin(p.pos+(-96,64,0),false);john.Camping=true;john.CampSpot=john.pos;john.CampGoal=john.pos.XY;john.NextCampWander=99999;anchor=john.pos;
   for(int i=0;i<16;i++){let a=Actor.Spawn("ThreatDummy",p.pos+(200+(i%4)*40,-60+(i/4)*40,0));if(i==0)first=a;}
   let friend=Actor.Spawn("ThreatDummy",p.pos+(100,160,0));friend.bFRIENDLY=true;
   let dead=Actor.Spawn("ThreatDummy",p.pos+(140,160,0));dead.health=0;
   john.target=friend;john.LastShotTime=level.time-200;john.ScanForThreats();
   Console.Printf("THREAT %s: counts 16 hostiles, excludes friends/dead (%d)",john.VisibleThreats==16?"PASS":"FAIL",john.VisibleThreats);
   Console.Printf("THREAT %s: quiet scan uses 8 tics and replaces friendly target",john.NextTargetScan-level.time==8 && john.CombatTarget(john.target)?"PASS":"FAIL");
   john.LastShotTime=level.time;john.ScanForThreats();
   Console.Printf("THREAT %s: active scan uses 35 tics",john.NextTargetScan-level.time==35?"PASS":"FAIL");
   CVar.FindCVar("blnk_weaponstyle").SetInt(1);
   int normal=0;int crowded=0;
   for(int mode=0;mode<2;mode++)
   {
    john.VisibleThreats=mode==0?15:16;
    for(int i=0;i<400;i++)
    {
     john.SetStateLabel("Missile");
     bool heavy=john.InStateSequence(john.curstate,john.FindState("BFG")) || john.InStateSequence(john.curstate,john.FindState("Rocket")) || john.InStateSequence(john.curstate,john.FindState("Plasma"));
     if(heavy){if(mode==0)normal++;else crowded++;}
    }
   }
   Console.Printf("THREAT %s: crowd heavy choices %d/400 vs normal %d/400",crowded>normal+100?"PASS":"FAIL",crowded,normal);
   john.target=null;john.LastShotTime=level.time-200;john.NextTargetScan=0;john.SetStateLabel("See");
  }
  if(level.time==120)
  {
   Console.Printf("THREAT %s: camper acquires and fires",john.LastShotTime>10?"PASS":"FAIL");
   Console.Printf("THREAT %s: camp anchor preserved (drift %.3f)",(john.pos.XY-anchor.XY).Length()<1?"PASS":"FAIL",(john.pos.XY-anchor.XY).Length());
  }
 }
}
