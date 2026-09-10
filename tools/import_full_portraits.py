"""Keep full source detail; engine texture scale controls the HUD/tally size."""
from pathlib import Path
import re
import numpy as np
from PIL import Image
root=Path(__file__).resolve().parents[1]
defs=[]
for person,prefix in [('jay','JAY'),('tom','TOM')]:
 for suffix in ['LEFT','FACE','RIGHT']:
  name=prefix+suffix
  im=Image.open(root/'art'/f'{person}-portraits'/f'{name}.png').convert('RGBA')
  a=np.array(im);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
  a[(b>80)&(b-r>45)&(b-g>45),3]=0
  # No thumbnail, crop or resampling: preserve alignment and every source pixel.
  out=root/'mod/PATCHES'/f'{person}faces';out.mkdir(exist_ok=True)
  Image.fromarray(a).save(out/f'{name}.png')
  defs.append(f'Graphic {name}, {im.width}, {im.height}\n{{ XScale {im.width/46:.8f} YScale {im.height/49:.8f}\n Patch "PATCHES/{person}faces/{name}.png", 0, 0\n}}\n')
p=root/'mod/TEXTURES';s=p.read_text()
marker='// Full-detail Jay and Tom portraits'
# A bounded generated block permits independent sprite generators to coexist.
s=re.sub(r'// Full-detail Jay and Tom portraits\n.*?// End full-detail portraits\n?', '',s,flags=re.S)
p.write_text(s+'\n'+marker+'\n'+''.join(defs)+'// End full-detail portraits\n')
