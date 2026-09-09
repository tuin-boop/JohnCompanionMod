from pathlib import Path
import zipfile
root=Path(__file__).resolve().parents[1]
output=root/'dist/Romero_Carmack_Companion_Control.pk3'
output.parent.mkdir(exist_ok=True)
with zipfile.ZipFile(output,'w',zipfile.ZIP_DEFLATED) as archive:
    for path in sorted((root/'mod').rglob('*')):
        if path.is_file(): archive.write(path,path.relative_to(root/'mod').as_posix())
with zipfile.ZipFile(output) as archive:
    assert archive.testzip() is None
print(output)
