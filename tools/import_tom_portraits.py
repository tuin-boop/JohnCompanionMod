from pathlib import Path
import numpy as np
from PIL import Image
root=Path(__file__).resolve().parents[1]
for name in ['TOMLEFT','TOMFACE','TOMRIGHT']:
 im=Image.open(root/'art/tom-portraits'/f'{name}.png').convert('RGBA')
 a=np.array(im);r,g,b=[a[:,:,i].astype(int) for i in range(3)]
 a[(b>80)&(b-r>45)&(b-g>45),3]=0
 im=Image.fromarray(a);im=im.crop(im.getbbox());im.thumbnail((46,49),Image.Resampling.NEAREST)
 out=Image.new('RGBA',(46,49));out.alpha_composite(im,((46-im.width)//2,49-im.height))
 out.save(root/'mod/GRAPHICS'/f'{name}.png')
