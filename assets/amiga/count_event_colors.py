from shared import *
import pathlib
from PIL import Image,ImageOps
import bitplanelib

params = [{"speed_bar":False},  # swim
{"speed_bar":False},  # shoot
{"speed_bar":True},   # horse
{"speed_bar":False},  # archery
{"speed_bar":True},   # triple
{"speed_bar":True},  # weight
{"speed_bar":True},   # pole
]
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
    playfield_reduced = playfield.quantize(colors=8,dither=0).convert('RGB')

    lower_panel = Image.new("RGB",(256,196-height))
    lower_panel.paste(img,(0,-64-height))
    lower_panel_palette = bitplanelib.palette_extract(lower_panel)

    #lower_panel.save(f"lower_{i}.png")
    print(i,len(upper_panel_palette),len(playfield_palette),len(lower_panel_palette))
