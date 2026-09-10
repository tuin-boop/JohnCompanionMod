"""Extract complete death silhouettes and replace only death texture definitions."""
from pathlib import Path
import re
import numpy as np
from PIL import Image,ImageDraw
root=Path(__file__).resolve().parents[1]
def key(im):
 a=np.array(im.convert('RGBA'));r,g,b=[a[:,:,i].astype(int) for i in range(3)]
 a[(r-g>25)&(b-g>25)&(r>30)&(b>30),3]=0
 return Image.fromarray(a)
def runs(occupied):
 result=[];start=None
 for x,v in enumerate(list(occupied)+[False]):
  if v and start is None:start=x
  if not v and start is not None:
   if x-start>10:result.append((start,x))
   start=None
 return result
sheet=key(Image.open(root/'art/death-repair/single-gun-corpses.png'))
bands=runs((np.array(sheet)[:,:,3]>0).sum(axis=1)>5);assert len(bands)==5
fixed={}
for pref,(top,bottom) in zip(['JC06','SWMK','JAYW','TOMH','TMPR'],bands):
 im=sheet.crop((0,top,sheet.width,bottom));fixed[pref]=im.crop(im.getbbox())
p=root/'mod/TEXTURES';text=p.read_text()
for pref in ['JCMA','JR05','JC06','SWMK','JAYW','TOMH','TMPR']:
 row=Image.open(root/f'art/death-repair/{pref}-death-row.png').convert('RGBA')
 spans=runs((np.array(row)[:,:,3]>0).sum(axis=0)>2);assert len(spans)==5,(pref,spans)
 boundaries=[0]+[(spans[i-1][1]+spans[i][0])//2 for i in range(1,5)]+[row.width]
 cells=[]
 for left,right in zip(boundaries,boundaries[1:]):
  im=row.crop((left,0,right,row.height))
  # Young Carmack's preceding row extends into this strip: exclude its feet.
  bands=runs((np.array(im)[:,:,3]>0).sum(axis=1)>0)
  top,bottom=max(bands,key=lambda b:b[1]-b[0]);im=im.crop((0,top,im.width,bottom))
  cells.append(im.crop(im.getbbox()))
 for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):
  pattern=rf'Sprite {pref}{frame}0,.*?\n\}}\s*'
  old=re.search(pattern,text,re.S);assert old,(pref,frame)
  scale=float(re.search(rf'Sprite {pref}A1,.*?XScale\s+([\d.]+)',text,re.S)[1]);im=cells[col]
  if col==4 and pref in fixed:
   original_width=im.width;im=fixed[pref];scale*=im.width/original_width
  # Transparent border provides a verifiable safety margin on every edge.
  padded=Image.new('RGBA',(im.width+4,im.height+4));padded.alpha_composite(im,(2,2));im=padded
  out=root/f'mod/PATCHES/deathfixed/{pref}';out.mkdir(parents=True,exist_ok=True);im.save(out/f'{frame}.png')
  w,h=im.size
  new=f'Sprite {pref}{frame}0, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h-2}\n Patch "PATCHES/deathfixed/{pref}/{frame}.png", 0, 0 {{}}\n}}\n\n'
  text=text[:old.start()]+new+text[old.end():]
classic=key(Image.open(root/'art/death-repair/classic-two-hands.png'))
bands=runs((np.array(classic)[:,:,3]>0).sum(axis=1)>5);assert len(bands)==2
for frame,(top,bottom),original_width in zip('KL',bands,[290,352]):
 im=classic.crop((0,top,classic.width,bottom));im=im.crop(im.getbbox())
 scale=6.55357143*im.width/original_width
 padded=Image.new('RGBA',(im.width+4,im.height+4));padded.alpha_composite(im,(2,2));im=padded
 out=root/'mod/PATCHES/deathfixed/JCLS';out.mkdir(parents=True,exist_ok=True);im.save(out/f'{frame}.png')
 w,h=im.size
 new=f'Sprite JCLS{frame}0, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h-2}\n Patch "PATCHES/deathfixed/JCLS/{frame}.png", 0, 0 {{}}\n}}\n\n'
 text=re.sub(rf'Sprite JCLS{frame}0,.*?\n\}}\s*',lambda _:new,text,flags=re.S)
p.write_text(text)
# Review every skin, including both Romero sets.
items=[]
for m in re.finditer(r'Sprite\s+(\w{4})([I-N])0,.*?(?=\nSprite|\nGraphic|\Z)',text,re.S):
 patch=re.search(r'Patch\s+"([^"]+)"',m[0])
 if patch:items.append((m[1],m[2],patch[1]))
groups=list(dict.fromkeys(i[0] for i in items));out=Image.new('RGB',(1200,200*len(groups)),(55,55,55));d=ImageDraw.Draw(out)
for pref,frame,path in items:
 im=Image.open(root/'mod'/path).convert('RGBA');im.thumbnail((190,164));x=(ord(frame)-73)*200;y=groups.index(pref)*200
 out.paste(im,(x,y+25),im);d.text((x+3,y+5),pref+frame+'0',fill='white')
out.save(root/'tests/death-audit-after.png')
print('Repaired 44 death texture definitions across eight skins; all nine skins included in review.')
