from PIL import Image,ImageOps
import os,sys,bitplanelib,subprocess,json,pathlib

this_dir = pathlib.Path(__file__).absolute().parent

data_dir = this_dir / ".." / ".."
src_dir = this_dir / ".." / ".." / "src" / "amiga"

sheets_path = this_dir / ".." / "sheets"
dump_dir = this_dir / "dumps"

used_sprite_cluts_file = this_dir / "used_sprite_cluts.json"
used_tile_cluts_file = this_dir / "used_tile_cluts.json"
used_graphics_dir = this_dir / "used_graphics"

def palette_pad(palette,pad_nb):
    palette += (pad_nb-len(palette)) * [(0x10,0x20,0x30)]

def ensure_empty(d):
    if os.path.exists(d):
        for f in os.listdir(d):
            x = os.path.join(d,f)
            if os.path.isfile(x):
                os.remove(x)
    else:
        os.makedirs(d)

def ensure_exists(d):
    if os.path.exists(d):
        pass
    else:
        os.makedirs(d)

sr2 = lambda a,b : set(range(a,b,2))

player_sprite_pairs = (sr2(0x0,0x16) |
{0xb1,0xac,0XA0,0xA4,0x11E,0xa2,0xB4,0xBE,0x1B0,0x193,0x152,0x1A,0x8A,0x1B2,0x1c,0x14A,0x17E,0x1B8,0x1BA,0X150,0x188,0x180,0x111,
0x50,0x54,0x58,0x88,0x176,0X120,0x124,0x128,0x130,0x134,0x138,0x140,0x142,0x148,0x1F0,0x1F8,0x1FA,0x5C,0x13C,0x12C,0x18,0x195,0x10A,0x10D} |
 sr2(0X114,0x11C) | sr2(0x106,0x10C) |
sr2(0x1E0,0x1E6) | sr2(0x1E8,0x1EE) | # shoot
sr2(0x1AC,0x1B0) |
sr2(0x182,0x186) | sr2(0X18A,0x18E)
)

group_sprite_pairs = player_sprite_pairs | {0x168,0x170,0x160,0x146,0x14E,0x1A8} |sr2(0x2A,0x30)

def get_sprite_names():

    rval = dict()
    rval = {k:"player" for k in player_sprite_pairs}
    rval[0x1E6] = "gun"
    rval[0x1EE] = "go"
    rval[0x16A] = "points"
    rval[0x2A] = "shadow"
    rval[0x2C] = "shadow"
    rval[0x2E] = "shadow"
##    rval[0x3D] = "cursor"
##    rval[0x80] = "gunshot"
##    rval[0xA7] = "bar"
##    rval[0xB0] = rval[0xB8] = "up_arrow"
##    rval |= {k:"bystanders" for k in {0xDE,0xF4,0xF5}}
##    #rval |= {k:"" for k in {0xDE,0xF4,0xF5}}
##    rval |= {k:"referee" for k in sr2(0x62,0x68) | {0x68,0x69,0x6A,0x6B,0x6C,0x6D,
##    0x82,0x83,0x84,0x86}}
##    rval |= {k:"javelin" for k in range(0xE0,0xF1)}
##    rval |= {k:"hammer" for k in sr2(0x34,0x3E)}
    return rval

def get_mirror_sprites():
    """ return the index of the sprites that need mirroring
as opposed to Gyruss, most of the sprites don't

"""
    rval = ({0x1E6,0x1EE,0X138,0X1AC,0X110,0X130,0X124,0X12C,0X13C,0X134,0X113,0x103,0x1AE,0x145,0x111} | sr2(0x102,0x10A)|
    sr2(0x114,0x120)  # swimmers
    )
    return rval

alphanum_tile_codes = set(range(0,10)) | set(range(65-48,65+27-48))

if __name__ == "__main__":
    raise Exception("no main!")