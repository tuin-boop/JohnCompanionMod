from pathlib import Path
import numpy as np
from PIL import Image
root=Path(__file__).resolve().parents[1]
im=Image.open(root/'art/TomHallYoung-Sprite-Sheet.png').convert('RGBA');a=np.array(im)
r,g,b=[a[:,:,i].astype(int) for i in range(3)]
a[(r-g>25)&(b-g>25)&(r>30)&(b>30),3]=0
im=Image.fromarray(a)
xs=[round(x*im.width/992) for x in [0,198,397,595,794,992]]
ys=[round(y*im.height/1586) for y in [0,212,411,613,816,1018,1214,1404,1586]]
out=root/'mod/PATCHES/tomhall';out.mkdir(parents=True,exist_ok=True)
arts={};defs=[]
for row in range(8):
 for col in range(5):
  cell=im.crop((xs[col],ys[row],xs[col+1],ys[row+1]));assert cell.getbbox();cell=cell.crop(cell.getbbox());cell.save(out/f'{row}-{col}.png');arts[row,col]=cell
scale=arts[0,0].height/56
mapping={1:(0,False),2:(1,True),3:(2,True),4:(3,True),5:(4,False),6:(3,False),7:(2,False),8:(1,False)}
def sprite(frame,rot,row,col,flip):
 cell=arts[row,col];w,h=cell.size
 defs.append(f'Sprite TOMH{frame}{rot}, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h}\n Patch "PATCHES/tomhall/{row}-{col}.png", 0, 0 {{'+(' FlipX ' if flip else '')+'}\n}\n')
for row,frame in enumerate('ABCDEFG'):
 for rot,(col,flip) in mapping.items():
  use=row
  if rot==5 and frame=='F':use=4
  sprite(frame,rot,use,col,flip)
for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):sprite(frame,0,7,col,False)
p=root/'mod/TEXTURES';s=p.read_text();s=s.split('// Tom Hall sprites')[0];p.write_text(s+'\n// Tom Hall sprites\n'+''.join(defs))
p=root/'mod/TEXTURES'
p.write_text(p.read_text()+'\nGraphic TOMTALLY,46,49 { XScale 1.4375 YScale 1.4375 Patch "GRAPHICS/TOMFACE.png",0,0 }\n')
