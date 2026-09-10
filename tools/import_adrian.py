"""Import Young Adrian's sheet and full-resolution supplied portraits."""
from pathlib import Path
import re
import numpy as np
from PIL import Image
root=Path(__file__).resolve().parents[1]
im=Image.open(root/'art/YoungAdrianCarmack-Sprite-Sheet.png').convert('RGBA')
a=np.array(im);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
a[(r-g>25)&(b-g>25)&(r>30)&(b>30),3]=0
im=Image.fromarray(a)
def runs(v):
 out=[];start=None
 for i,yes in enumerate(list(v)+[False]):
  if yes and start is None:start=i
  if not yes and start is not None:
   if i-start>8:out.append((start,i))
   start=None
 return out
ys=[round(y*im.height/1586) for y in [0,212,411,613,816,1018,1214,1404,1586]]
out=root/'mod/PATCHES/adrian';out.mkdir(parents=True,exist_ok=True)
arts={};defs=[]
for row in range(8):
 strip=im.crop((0,ys[row],im.width,ys[row+1]))
 spans=runs((np.array(strip)[:,:,3]>0).sum(axis=0)>2)
 assert len(spans)==5,(row,spans)
 boundaries=[0]+[(spans[i-1][1]+spans[i][0])//2 for i in range(1,5)]+[im.width]
 for col,(left,right) in enumerate(zip(boundaries,boundaries[1:])):
  cell=strip.crop((left,0,right,strip.height));cell=cell.crop(cell.getbbox())
  padded=Image.new('RGBA',(cell.width+4,cell.height+4));padded.alpha_composite(cell,(2,2))
  padded.save(out/f'{row}-{col}.png');arts[row,col]=padded
scale=(arts[0,0].height-4)/56
mapping={1:(0,False),2:(1,True),3:(2,True),4:(3,True),5:(4,False),6:(3,False),7:(2,False),8:(1,False)}
def sprite(frame,rot,row,col,flip=False):
 cell=arts[row,col];w,h=cell.size
 defs.append(f'Sprite ADRN{frame}{rot}, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h-2}\n Patch "PATCHES/adrian/{row}-{col}.png", 0, 0 {{'+(' FlipX ' if flip else '')+'}\n}\n')
for row,frame in enumerate('ABCDEFG'):
 for rot,(col,flip) in mapping.items():sprite(frame,rot,4 if rot==5 and frame=='F' else row,col,flip)
for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):sprite(frame,0,7,col)
for suffix in ['LEFT','FACE','RIGHT']:
 name='ADR'+suffix;face=Image.open(root/f'art/adrian-portraits/{name}.png').convert('RGBA')
 a=np.array(face);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
 a[(b>80)&(b-r>45)&(b-g>45),3]=0
 target=root/'mod/PATCHES/adrianfaces';target.mkdir(exist_ok=True)
 Image.fromarray(a).save(target/f'{name}.png')
 defs.append(f'Graphic {name}, {face.width}, {face.height}\n{{ XScale {face.width/46:.8f} YScale {face.height/49:.8f}\n Patch "PATCHES/adrianfaces/{name}.png", 0, 0\n}}\n')
p=root/'mod/TEXTURES';s=re.sub(r'// Young Adrian assets\n.*?// End Young Adrian assets\n?','',p.read_text(),flags=re.S)
p.write_text(s+'\n// Young Adrian assets\n'+''.join(defs)+'// End Young Adrian assets\n')
review=Image.new('RGB',(1000,180),(55,55,55))
for col in range(5):
 cell=arts[7,col].copy();cell.thumbnail((196,160));review.paste(cell,(col*200,10),cell)
review.save(root/'tests/adrian-death-review.png')
