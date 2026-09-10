from pathlib import Path
import re
import numpy as np
from PIL import Image
root=Path(__file__).resolve().parents[1]
im=Image.open(root/'art/TomHallPresent-Sprite-Sheet.png').convert('RGBA');a=np.array(im)
r,g,b=[a[:,:,i].astype(int) for i in range(3)]
a[(r-g>25)&(b-g>25)&(r>30)&(b>30),3]=0;im=Image.fromarray(a)
xs=[round(x*im.width/992) for x in [0,198,397,595,794,992]]
ys=[round(y*im.height/1586) for y in [0,212,411,613,816,1018,1214,1404,1586]]
out=root/'mod/PATCHES/tompresent';out.mkdir(exist_ok=True)
arts={};defs=[]
# Generated sheet has three walk phases, then aim/fire/pain. Ignore its spare row.
for row in [0,1,2,3,4,5,7]:
 for col in range(5):
  cell=im.crop((xs[col],ys[row],xs[col+1],ys[row+1]));assert cell.getbbox()
  cell=cell.crop(cell.getbbox());cell.save(out/f'{row}-{col}.png');arts[row,col]=cell
scale=arts[0,0].height/56
mapping={1:(0,False),2:(1,True),3:(2,True),4:(3,True),5:(4,False),6:(3,False),7:(2,False),8:(1,False)}
def sprite(frame,rot,row,col,flip):
 w,h=arts[row,col].size
 defs.append(f'Sprite TMPR{frame}{rot}, {w}, {h}\n{{ XScale {scale:.8f} YScale {scale:.8f} Offset {w//2}, {h}\n Patch "PATCHES/tompresent/{row}-{col}.png", 0, 0 {{'+(' FlipX ' if flip else '')+'}\n}\n')
for row,frame in zip([0,1,2,1,3,4,5],'ABCDEFG'):
 for rot,(col,flip) in mapping.items():sprite(frame,rot,3 if rot==5 and frame=='F' else row,col,flip)
for frame,col in zip('IJKLMN',[0,1,2,3,4,4]):sprite(frame,0,7,col,False)
im=Image.open(root/'art/TomHallPresent-Portraits.png').convert('RGBA')
for col,name in enumerate(['TMPLEFT','TMPFACE','TMPRIGHT']):
 cell=im.crop((round(col*im.width/3),0,round((col+1)*im.width/3),im.height));a=np.array(cell)
 r,g,b=[a[:,:,i].astype(int) for i in range(3)];a[(b>80)&(b-r>45)&(b-g>45),3]=0
 Image.fromarray(a).save(out/f'{name}.png')
 defs.append(f'Graphic {name}, {cell.width}, {cell.height}\n{{ XScale {cell.width/46:.8f} YScale {cell.height/49:.8f}\n Patch "PATCHES/tompresent/{name}.png", 0, 0\n}}\n')
p=root/'mod/TEXTURES';s=re.sub(r'// Present-day Tom assets\n.*?// End present-day Tom assets\n?', '',p.read_text(),flags=re.S)
p.write_text(s+'\n// Present-day Tom assets\n'+''.join(defs)+'// End present-day Tom assets\n')
