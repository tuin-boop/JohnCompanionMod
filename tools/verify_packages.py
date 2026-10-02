"""Validate release archives, decoded PNGs, and addon texture references."""
from io import BytesIO
from pathlib import Path
import re
from zipfile import ZipFile
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]

def check_png(data):
    with Image.open(BytesIO(data)) as image:
        image.verify()
    with Image.open(BytesIO(data)) as image:
        image.load()  # verify() alone does not fully decode pixel data
        return image.size

for package, source in [
    ('Romero_Carmack_Companion_Control.pk3', 'mod'),
    ('Himiko_Companion_Addon.pk3', 'addons/Himiko/mod'),
]:
    with ZipFile(ROOT / 'dist' / package) as archive:
        assert archive.testzip() is None, package
        names = archive.namelist()
        assert len(names) == len(set(n.lower() for n in names)), 'Duplicate entries'
        expected = {p.relative_to(ROOT / source).as_posix(): p
                    for p in (ROOT / source).rglob('*') if p.is_file()}
        assert set(names) == set(expected), 'Archive/source file mismatch'
        sizes = {}
        for name in names:
            data = archive.read(name)
            assert data == expected[name].read_bytes(), name
            if name.lower().endswith('.png'):
                sizes[name] = check_png(data)
        if source.startswith('addons/'):
            assert not any(re.search(r'Karin|Esther|KRNFACE|ESTFACE', n, re.I) for n in names)
            textures = archive.read('TEXTURES').decode()
            references = re.findall(r'Patch\s+"([^"]+)"', textures, re.I)
            assert references and all(ref in sizes for ref in references)
            for width, height, ref in re.findall(
                r'(?:Sprite|Graphic)\s+\w+,\s*(\d+),\s*(\d+)\s*\{[^{}]*?Patch\s+"([^"]+)"', textures):
                assert sizes[ref] == (int(width), int(height)), ref
            prefixes = ['HIMK','TINA','FRIR','TUIN','KUMI','ERNI','STEW',
                        'BRIN','SPNG','PTRK','PETR','MONK','KNWT','POPE']
            sprites = re.findall(r'Sprite\s+(\w+),', textures)
            expected_sprites = {p+f+str(r) for p in prefixes for f in 'ABCDEFG' for r in range(1,9)}
            expected_sprites |= {p+f+'0' for p in prefixes for f in 'IJKLMN'}
            assert len(sprites) == len(expected_sprites) and set(sprites) == expected_sprites
            script = archive.read('ZSCRIPT').decode()
            assert not re.search(r'Karin|Esther|KARN|ESTH', script)
        print(f'PASS {package}: {len(names)} entries, {len(sizes)} decoded PNGs')

for path in (ROOT / 'art').rglob('*.png'):
    check_png(path.read_bytes())
print('PASS source artwork PNGs')
