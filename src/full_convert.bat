..\assets\amiga\merge_used.py
..\assets\amiga\convert_graphics.py
6809to68k.py -i mot -o mit --data data.s --code conv.s -I include.inc hypersports_6809.asm
..\tools\post_process.py
rem goto skip_instrum
add_reg_log.py -s 4000 -e CF12 -p 1 hyper_sports.68k
:skip_instrum
rem m68k-amigaos-as --defsym MC68020=1 hyper_sports.68k 2>&1
rem build.bat

