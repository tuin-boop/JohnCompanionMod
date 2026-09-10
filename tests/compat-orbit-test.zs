version "4.8"
class CompatOrbitTest : EventHandler {
 override void WorldTick(){
 let h=NNR_HellTitle(EventHandler.Find("NNR_HellTitle"));
 if(level.time==20){
  let c=NNR_TuinCompatibility(EventHandler.Find("NNR_TuinCompatibility"));
  String rpgName="TuinRPGHandler";class<StaticEventHandler> actual=(class<StaticEventHandler>)(rpgName);
  Console.Printf("COMPAT %s: detection %d matches loaded RPG %d (saved CVar exists %d)",c.detected==(actual!=null)?"PASS":"FAIL",c.detected,actual!=null,CVar.FindCVar("tuin_enabled")!=null);
  if(actual)Console.Printf("COMPAT %s: title RPG handler suppressed",EventHandler.Find(actual)==null?"PASS":"FAIL");
 }
 if(level.time==300){Console.Printf("ORBIT %s: right arc and inward turn",h.camera.pos.X>89 && h.camera.angle>107?"PASS":"FAIL");level.MakeScreenShot();}
 if(level.time==900){Console.Printf("ORBIT %s: left arc and inward turn",h.camera.pos.X < -89 && h.camera.angle<73?"PASS":"FAIL");level.MakeScreenShot();}
 }
}
