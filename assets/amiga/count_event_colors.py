from shared import *
import pathlib
from PIL import Image,ImageOps
import bitplanelib

params = [{"name":"swim","speed_bar":False},
{"name":"shoot","speed_bar":False},
{"name":"horse","speed_bar":True},
{"name":"archery","speed_bar":False},
{"name":"triple","speed_bar":True},
{"name":"weight","speed_bar":True},
{"name":"pole","speed_bar":True},
]

full_playfield_palette = {(0, 0, 0),
 (0, 184, 171),
 (0, 222, 0),
 (0, 222, 251),
 (0, 255, 251),
 (33, 33, 251),
 (33, 184, 80),
 (104, 151, 171),
 (151, 151, 171),
 (184, 71, 80),
 (184, 184, 171),
 (222, 104, 80),
 (222, 184, 171),
 (222, 255, 0),
 (255, 0, 0),
 (255, 255, 251)}

for i,event in enumerate(sorted((this_dir / 'event_tiles').glob("*.png"))):
    img = Image.open(event)
    img = img.crop((0,0,256,256)) # restrict to left part

    upper_panel = Image.new("RGB",(256,64))
    upper_panel.paste(img)
    upper_panel_palette = bitplanelib.palette_extract(upper_panel)

    p = params[i]
    height = 120 if p["speed_bar"] else 128

    playfield = Image.new("RGB",(256,height))
    playfield.paste(img,(0,-64))
    playfield_palette = bitplanelib.palette_extract(playfield)
    #playfield_reduced = playfield.quantize(colors=8,dither=0).convert('RGB')

    lower_panel = Image.new("RGB",(256,196-height))
    lower_panel.paste(img,(0,-64-height))
    lower_panel_palette = bitplanelib.palette_extract(lower_panel)

    missing = full_playfield_palette - set(playfield_palette)
    #lower_panel.save(f"lower_{i}.png")
    print(f"{p['name']}: playfield_nb_colors: {len(playfield_palette)}, missing: {missing}")
