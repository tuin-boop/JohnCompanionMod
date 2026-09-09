version "4.8"
class RowCheckMenu : NNR_JohnMainMenu
{
 int ticks;bool drawn;
 override void Init(Menu parent,ListMenuDescriptor desc)
 {
  Super.Init(parent,desc);double previous=-100;bool ok=true;int count=0;
  for(int i=0;i<desc.mItems.Size();i++)if(desc.mItems[i].Selectable())
  {double y=desc.mItems[i].GetY();if(y-previous<16 || y>184)ok=false;previous=y;count++;}
  Console.Printf("MENUROWS %s: %d distinct selectable rows",ok?"PASS":"FAIL",count);
 }
 override void Drawer(){Super.Drawer();drawn=true;}
 override void Ticker(){Super.Ticker();if(drawn){ticks++;if(ticks==20)level.MakeScreenShot();}}
}
class RowOpen : EventHandler
{
 override void WorldTick(){if(level.time==30)Menu.SetMenu('MainMenu');}
}
