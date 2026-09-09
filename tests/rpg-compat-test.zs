version "4.8"
class RPGCompatCheck : EventHandler
{
 ui bool checked,selected,closed;ui int frames;
 override void RenderOverlay(RenderEvent e)
 {
  frames++;
  if(level.MapName=="TITLEMAP")
  {
   if(frames==150){Console.Printf("RPGCOMPAT %s: title has no forced class menu",Menu.GetCurrentMenu()==null?"PASS":"FAIL");level.MakeScreenShot();}
   return;
  }
  if(!selected && frames>150 && Menu.GetCurrentMenu()!=null)
  {
   Console.Printf("RPGCOMPAT %s: RPG handler active in game",EventHandler.Find("TuinRPGHandler")!=null?"PASS":"FAIL");
   EventHandler.SendNetworkEvent("tuin_choose_class",4);selected=true;
  }
  if(selected && !closed)
  {
   let data=TuinRPGHandler.GetPlayerData(players[0].mo);
   if(data && data.PlayerClass==4)
   {
    Console.Printf("RPGCOMPAT PASS: class choice applied");
    if(Menu.GetCurrentMenu())Menu.GetCurrentMenu().MenuEvent(Menu.MKEY_Back,false);
    closed=true;
   }
  }
  if(closed && !checked && Menu.GetCurrentMenu()==null){Console.Printf("RPGCOMPAT PASS: returned from class menu to gameplay");checked=true;}
 }
}

