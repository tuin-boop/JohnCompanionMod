"""Build all sixteen extra companions. Source art stays at its original resolution."""
from pathlib import Path
import runpy
from PIL import Image
import numpy as np
from zipfile import ZipFile, ZIP_DEFLATED
root=Path(__file__).resolve().parent
ctx=runpy.run_path(str(root/'import_assets.py'))
runs=ctx['runs'];defs=[]
for name,prefix,expected in [('Tina','TINA',8),('Karin','KARN',7),('Frier','FRIR',7),('Tuin','TUIN',7),('Esther','ESTH',7),('Kumi','KUMI',7),('Ernie','ERNI',7),('Stewie','STEW',7),('Brian','BRIN',7),('SpongeBob','SPNG',7),('Patrick','PTRK',7),('Peter','PETR',7),('Moneko','MONK',7),('Knootewoot','KNWT',7),('Pope','POPE',6)]:
 im=Image.open(root/f'../../art/{name}/{name}-Sprite-Sheet.png').convert('RGBA')
 a=np.array(im);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
 key_delta=65 if name=="Tina" else 12
 if name in ("Stewie","Patrick","Peter"):a[(b-r>70)&(b-g>70)&(b>120),3]=0
 elif name in ("Kumi","Ernie","Brian","SpongeBob","Moneko"):a[(b-r>20)&(b-g>20)&(b>35),3]=0
 else:a[(r-g>key_delta)&(b-g>key_delta)&(r>25)&(b>25),3]=0
 a[a[:,:,3]==0,:3]=0;im=Image.fromarray(a)
 ys=runs((a[:,:,3]>0).sum(axis=1)>5);assert len(ys)==expected,(name,ys)
 arts={};out=root/f'mod/PATCHES/{name}';out.mkdir(exist_ok=True)
 for row,(top,bottom) in enumerate(ys):
  strip=im.crop((0,top,im.width,bottom));xs=runs((np.array(strip)[:,:,3]>0).sum(axis=0)>1)
  assert len(xs)==5,(name,row,xs)
  for col,(left,right) in enumerate(xs):
   cell=strip.crop((left,0,right,strip.height));cell=cell.crop(cell.getbbox())
   pad=Image.new('RGBA',(cell.width+4,cell.height+4));pad.alpha_composite(cell,(2,2));pad.save(out/f'{row}-{col}.png');arts[row,col]=pad
 scale=(arts[0,0].height-4)/56
 def sprite(frame,rot,row,col,flip=False):
  w,h=arts[row,col].size
  defs.append(f'Sprite {prefix}{frame}{rot}, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h-2} Patch "PATCHES/{name}/{row}-{col}.png", 0, 0 {{'+(' FlipX ' if flip else '')+'} }\n')
 # Karin has two walking rows; reuse the first for the third animation beat.
 rows=list(range(7)) if expected==8 else [0,1,1,1,2,3,4] if expected==6 else [0,1,2,1,3,4,5]
 for frame,row in zip('ABCDEFG',rows):
  for rot,(col,flip) in ctx['mapping'].items():
   source=rows[4] if frame=='F' and rot==5 else row
   if name=='Ernie' and frame=='E' and col in (2,3):source=0 # use no-flash ready pose for these angles
   sprite(frame,rot,source,col,flip)
 for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):sprite(frame,0,expected-1,col)
 if name in ('Karin','Stewie','Brian','SpongeBob','Patrick','Peter','Moneko'):
  # Temporary in-style portrait from the idle sprite until a supplied HUD portrait arrives.
  head=arts[0,0];head=head.crop((0,0,head.width,int(head.height*({'Stewie':.55,'Brian':.43,'SpongeBob':.36,'Patrick':.43,'Peter':.34,'Moneko':.51}.get(name,.30)))));head=head.crop(head.getbbox())
  texture={'Karin':'KRNFACE','Stewie':'STWFACE','Brian':'BRIFACE','SpongeBob':'SPGFACE','Patrick':'PATFACE','Peter':'PETFACE','Moneko':'MONFACE'}[name]
  head.save(root/f'mod/PATCHES/{texture}.png')
  defs.append(f'Graphic {texture}, {head.width}, {head.height} {{ XScale {head.width/46} YScale {head.height/49} Patch "PATCHES/{texture}.png", 0, 0 }}\n')
for src,name in [('Tina-center-v3','TINFACE'),('Tina-side-v3','TINLEFT')]:
 face=Image.open(root/f'../../art/Tina/portraits/{src}.png').convert('RGBA');a=np.array(face)
 r,g,b=[a[:,:,i].astype(int) for i in range(3)]
 a[a[:,:,:3].max(axis=(1,2))<40,:,3]=0
 a[((b-r>20)&(b-g>20)&(b>35))|((r<5)&(g<5)&(b<5)&(np.indices(r.shape)[0]<22)),3]=0
 a[a[:,:,3]==0,:3]=0;face=Image.fromarray(a);face=face.crop(face.getbbox());face.save(root/f'mod/PATCHES/{name}.png')
 defs.append(f'Graphic {name}, {face.width}, {face.height} {{ XScale {face.width/46} YScale {face.height/49} Patch "PATCHES/{name}.png", 0, 0 }}\n')
face=Image.open(root/'../../art/Frier/Frier-Portrait.png').convert('RGBA');a=np.array(face)
r,g,b=[a[:,:,i].astype(int) for i in range(3)]
a[(r-g>12)&(b-g>12)&(r>25)&(b>25),3]=0;a[a[:,:,3]==0,:3]=0
face=Image.fromarray(a);face=face.crop(face.getbbox());face.save(root/'mod/PATCHES/FRIFACE.png')
defs.append(f'Graphic FRIFACE, {face.width}, {face.height} {{ XScale {face.width/46} YScale {face.height/49} Patch "PATCHES/FRIFACE.png", 0, 0 }}\n')
for who,texture in [('Tuin','TUINFACE'),('Esther','ESTFACE'),('Kumi','KUMIFACE'),('Ernie','ERNFACE'),('Knootewoot','KNWFACE'),('Pope','POPFACE')]:
 face=Image.open(root/f'../../art/{who}/{who}-Portrait.png').convert('RGBA');a=np.array(face)
 if who in ('Kumi','Pope'):pass # supplied PNG already has transparency; preserve its black outlines
 elif who=='Ernie':
  r,g,b=[a[:,:,i].astype(int) for i in range(3)];a[(b-r>20)&(b-g>20)&(b>35),3]=0
 elif who=='Tuin':
  # Remove only border-connected black background, preserving eyes and dark facial shading.
  from collections import deque
  mask=(a[:,:,:3].max(axis=2)<28);seen=np.zeros(mask.shape,dtype=bool);h,w=mask.shape
  todo=deque([(x,0) for x in range(w)]+[(x,h-1) for x in range(w)]+[(0,y) for y in range(h)]+[(w-1,y) for y in range(h)])
  while todo:
   x,y=todo.popleft()
   if x<0 or y<0 or x>=w or y>=h or seen[y,x] or not mask[y,x]:continue
   seen[y,x]=True;todo.extend([(x-1,y),(x+1,y),(x,y-1),(x,y+1)])
  a[seen,3]=0
 else:
  r,g,b=[a[:,:,i].astype(int) for i in range(3)];a[(r-g>12)&(b-g>12)&(r>25)&(b>25),3]=0
 a[a[:,:,3]==0,:3]=0;face=Image.fromarray(a);face=face.crop(face.getbbox());face.save(root/f'mod/PATCHES/{texture}.png')
 defs.append(f'Graphic {texture}, {face.width}, {face.height} {{ XScale {face.width/46} YScale {face.height/49} Patch "PATCHES/{texture}.png", 0, 0 }}\n')
with (root/'mod/TEXTURES').open('a') as f:f.write(''.join(defs))
with ZipFile(root/'../../dist/Himiko_Companion_Addon.pk3','w',ZIP_DEFLATED) as z:
 for f in sorted((root/'mod').rglob('*')):
  if f.is_file():z.write(f,f.relative_to(root/'mod').as_posix())
print('Packaged all sixteen extras.')
