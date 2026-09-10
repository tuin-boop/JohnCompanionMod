from pathlib import Path
from PIL import Image
import numpy as np
from zipfile import ZipFile
root=Path(__file__).resolve().parent
im=Image.open(root/'art/Himiko-Sprite-Sheet.png').convert('RGBA')
a=np.array(im);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
# Include dark magenta fringe pixels, not just the bright background.
# Cyan tubes have more green than red and remain untouched.
a[(r-g>12)&(b-g>12)&(r>25)&(b>25),3]=0
a[a[:,:,3]==0,:3]=0
im=Image.fromarray(a)
def runs(v):
 out=[];start=None
 for i,on in enumerate(list(v)+[False]):
  if on and start is None:start=i
  if not on and start is not None:
   if i-start>5:out.append((start,i))
   start=None
 return out
ys=runs((a[:,:,3]>0).sum(axis=1)>5)
assert len(ys)==8,ys
out=root/'mod/PATCHES';out.mkdir(exist_ok=True)
arts={}
for row,(top,bottom) in enumerate(ys):
 strip=im.crop((0,top,im.width,bottom))
 xs=runs((np.array(strip)[:,:,3]>0).sum(axis=0)>1)
 assert len(xs)==5,(row,xs)
 for col,(left,right) in enumerate(xs):
  cell=strip.crop((left,0,right,strip.height));cell=cell.crop(cell.getbbox())
  pad=Image.new('RGBA',(cell.width+4,cell.height+4));pad.alpha_composite(cell,(2,2))
  pad.save(out/f'{row}-{col}.png');arts[row,col]=pad
scale=(arts[0,0].height-4)/56
defs=[]
mapping={1:(0,False),2:(1,True),3:(2,True),4:(3,True),5:(4,False),6:(3,False),7:(2,False),8:(1,False)}
def sprite(frame,rot,row,col,flip=False):
 w,h=arts[row,col].size
 defs.append(f'Sprite HIMK{frame}{rot}, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h-2} Patch "PATCHES/{row}-{col}.png", 0, 0 {{'+(' FlipX ' if flip else '')+'} }\n')
for row,frame in enumerate('ABCDEFG'):
 for rot,(col,flip) in mapping.items():sprite(frame,rot,4 if frame=='F' and rot==5 else row,col,flip)
for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):sprite(frame,0,7,col)
# Preserve the full supplied portraits; key blue and its darker edge fringe.
for name in ['HIKFACE','HIKLEFT','HIKRIGHT']:
 face=Image.open(root/f'art/portraits/{name}.png').convert('RGBA')
 pixels=np.array(face);r,g,b=[pixels[:,:,i].astype(int) for i in range(3)]
 pixels[(b-r>20)&(b-g>20)&(b>35),3]=0
 pixels[pixels[:,:,3]==0,:3]=0
 Image.fromarray(pixels).save(out/f'{name}.png')
 defs.append(f'Graphic {name}, {face.width}, {face.height} {{ XScale {face.width/46} YScale {face.height/49} Patch "PATCHES/{name}.png", 0, 0 }}\n')
(root/'mod/TEXTURES').write_text(''.join(defs))
with ZipFile(root/'../../dist/Himiko_Companion_Addon.pk3','w') as z:
 for f in sorted((root/'mod').rglob('*')):
  if f.is_file():z.write(f,f.relative_to(root/'mod').as_posix())
print('Imported 40 cells, registered 62 sprite views, packaged addon.')
