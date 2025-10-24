import subprocess,os,struct,glob,tempfile
import shutil

from shared import *

gamename = "hyper_sports"
sox = "sox"

sound_dir = this_dir / ".." / "sounds"

def convert():
    if not shutil.which("sox"):
        raise Exception("sox command not in path, please install it")
    # BTW convert wav to mp3: ffmpeg -i input.wav -codec:a libmp3lame -b:a 330k output.mp3

    #wav_files = glob.glob("sounds/*.wav")



    outfile = os.path.join(src_dir,"sounds.68k")
    sndfile = os.path.join(src_dir,"sound_entries.68k")


    hq_sample_rate = 12000  #{"aga":18004,"ecs":12000,"ocs":11025}[mode]
    lq_sample_rate = hq_sample_rate//2 # if aga_mode else 8000


    loop_channel = 2

    EMPTY_SND = "EMPTY_SND"
    sound_dict = {

    "CREDIT_3A_SND"               :{"index":0x3A,"channel":3,"sample_rate":hq_sample_rate},
    "CURSOR_MOVE_17_SND"            :{"index":0x17,"channel":3,"sample_rate":hq_sample_rate},
    "LETTER_ENTERED_18_SND"            :{"index":0x18,"channel":3,"sample_rate":hq_sample_rate},

    "BOUNCE_23_SND"            :{"index":0x23,"channel":2,"sample_rate":hq_sample_rate},
    "SOUND_24_SND"            :{"index":0x24,"channel":2,"sample_rate":hq_sample_rate},
    "HURRY_38_SND"            :{"index":0x38,"channel":3,"sample_rate":hq_sample_rate},

    "WIN_39_SND"            :{"index":0x39,"sample_rate":hq_sample_rate},
    "SOUND_3f_SND"            :{"index":0x3f,"sample_rate":hq_sample_rate},
     "SOUND_64_SND"            :{"index":0x64,"sample_rate":hq_sample_rate},
    "GUNSHOT_10_SND"            :{"index":0x10,"sample_rate":hq_sample_rate},
    "SPLASH_SND"            :{"index":0x15,"sample_rate":hq_sample_rate},
    "SWIM_14_SND"            :{"index":0x14,"sample_rate":hq_sample_rate},
    "STEP_01_SND"            :{"index":0x1,"sample_rate":hq_sample_rate},
    "SOUND_2A_SND"            :{"index":0x2A,"sample_rate":hq_sample_rate},
    "DROP_13_SND"            :{"index":0x13,"sample_rate":hq_sample_rate},
    "DROP_16_SND"            :{"index":0x16,"sample_rate":hq_sample_rate},
    "FALL_07_SND"            :{"index":0x7,"sample_rate":lq_sample_rate},
    "FALL_36_SND"            :{"index":0x36,"sample_rate":hq_sample_rate},
    "FALL_37_SND"            :{"index":0x37,"sample_rate":hq_sample_rate},
    "SFX_11_SND"            :{"index":0x11,"sample_rate":hq_sample_rate},
    "SFX_12_SND"            :{"index":0x12,"sample_rate":hq_sample_rate},
    "ZAP_0A_SND"            :{"index":0x0A,"sample_rate":hq_sample_rate},
    "ZAP_09_SND"            :{"index":0x09,"sample_rate":hq_sample_rate},
    "HORN_27_SND"            :{"index":0x27,"sample_rate":hq_sample_rate},
    "SOMMERSAULT_SND"            :{"index":0x1B,"sample_rate":hq_sample_rate},
    "PING_08_SND"            :{"index":0x08,"sample_rate":hq_sample_rate},
    "SOUND_22_SND"            :{"index":0x22,"sample_rate":hq_sample_rate},
    "SOUND_60_SND"            :{"index":0x60,"sample_rate":hq_sample_rate},
    "JUMP_19_SND"            :{"index":0x19,"sample_rate":hq_sample_rate},
    "JUMP_1A_SND"            :{"index":0x1A,"sample_rate":hq_sample_rate},
    "SOUND_04_SND"            :{"index":0x04,"sample_rate":hq_sample_rate},
    "SOUND_0E_SND"            :{"index":0x0E,"sample_rate":hq_sample_rate},
    "SOUND_0F_SND"            :{"index":0x0F,"sample_rate":hq_sample_rate},
    "TICK_1E_SND"            :{"index":0x1e,"sample_rate":hq_sample_rate},
    "TICK_1F_SND"            :{"index":0x1f,"sample_rate":hq_sample_rate},
    "SOUND_20_SND"            :{"index":0x20,"sample_rate":lq_sample_rate},
    "SOUND_21_SND"            :{"index":0x21,"sample_rate":lq_sample_rate},
    "SWOOSH_SND"            :{"index":0xB,"sample_rate":hq_sample_rate},
    "SWOOSH_1D_SND"            :{"index":0x1D,"sample_rate":lq_sample_rate},
    "PING_05_SND"            :{"index":0x5,"sample_rate":hq_sample_rate},
   "DROP_06_SND"            :{"index":0x6,"sample_rate":hq_sample_rate},
    "PING_61_SND"            :{"index":0x61,"sample_rate":hq_sample_rate},
    "PING_62_SND"            :{"index":0x62,"sample_rate":hq_sample_rate},
    "PING_63_SND"            :{"index":0x63,"sample_rate":hq_sample_rate},
    "PING_65_SND"            :{"index":0x65,"sample_rate":hq_sample_rate},
    "PING_66_SND"            :{"index":0x66,"sample_rate":hq_sample_rate},
    "CHEERING_SND"            :{"index":0x41,"sample_rate":lq_sample_rate},

    "BLAST_BLOW_02_SND"            :{"index":0x02,"sample_rate":hq_sample_rate},
    "BLAST_ZAP_03_SND"            :{"index":0x03,"sample_rate":hq_sample_rate},


    }

    speech_list = set()
    # scan directory for speech
    for f in sound_dir.glob("*.wav"):
        sound_name = f.stem
        parts = sound_name.rsplit("_",maxsplit=1)
        if len(parts)>1:
            try:
                index = int(parts[1],16)
                if index > 0x7F:
                    speech_list.add(index)
                    # speech: auto-declare
                    entry = f"{sound_name}_SND"
                    # fix channel to avoid overlap
                    sound_dict[entry] = {"channel":3,"index":index,"sample_rate":lq_sample_rate}
            except ValueError:
                pass


    full_speech_list = set(range(0x80,0xDA))
    missing = full_speech_list - speech_list
    print("Missing speech samples: {}".format(",".join(hex(x) for x in sorted(missing))))


    for v in sound_dict.values():
        if "channel" not in v:
            v["channel"] = -1 # auto

    sound_dict.update({
    "RECORD_BROKEN_TUNE_SND"      :{"index":0x3C,"pattern":0x8,"volume":32},
    "CHARIOTS_TUNE_SND"      :{"index":0x2D,"pattern":0x3,"volume":32,"loops":True},
    "BEST_PLAYER_TUNE_SND"      :{"index":0x3E,"pattern":0xA,"volume":32},
    "GAME_OVER_TUNE_SND"      :{"index":0x3B,"pattern":0xC,"volume":32},
    "START_EVENT_TUNE_SND"      :{"index":0x3D,"pattern":0xE,"volume":32},
    "NAME_ENTRY_SND"      :{"index":0x40,"pattern":0x0,"volume":32,"loops":True},
})
    sound_dict["SOMMERSAULT_2_SND"] = {"index":0x1C,"same_as":"SOMMERSAULT_SND"}
    sound_dict["PING_66_SND"] = {"index":0x66,"same_as":"PING_65_SND"}

    dummy_sounds = [#0x40, # start music
    0x30,  # after start music
#0x3D, # swim event start
#0x3B, # game over music
#0x2D,  # chariots
0x42, # podium shit
0x43,  # win tune
0x44, # win tune
#0x3E, # 2P end round tune
#0x43, # win tune (followed by cheering)
0x47, # another win tune
0xFF, # ignore
    ]

    with open(os.path.join(src_dir,"..","sounds.inc"),"w") as f:
        for k,v in sorted(sound_dict.items(),key = lambda x:x[1]["index"]):
            f.write(f"\t.equ\t{k},  0x{v['index']:x}\n")

    max_sound = 0x100  # max(x["index"] for x in sound_dict.values())+1
    sound_table = [""]*max_sound
    sound_table_set_1 = ["\t.long\t0,0"]*max_sound

    for d in dummy_sounds:
        sound_table_set_1[d] = "\t.word\t3,0,0,0   | valid but muted"



    snd_header = rf"""
    # sound tables
    #
    # the "sound_table" table has 8 bytes per entry
    # first word: 0: no entry, 1: sample, 2: pattern from music module
    # second word: 0 except for music module: pattern number
    # longword: sample data pointer if sample, 0 if no entry and
    # 2 words: 0/1 noloop/loop followed by duration in ticks
    #
    # SOUND_ENTRY macro defines a ptplayer-compatible structure, with added the number
    # of ticks (PAL) giving the duration of the sample (offset 0xA)
    FXFREQBASE = 3579564

        .macro    SOUND_ENTRY    sound_name,size,channel,soundfreq,volume,priority,ticks
    \sound_name\()_sound:
        .long    \sound_name\()_raw
        .word   \size
        .word   FXFREQBASE/\soundfreq,\volume
        .byte    \channel
        .byte    \priority
        .word    \ticks
        .endm

    """

    def write_asm(contents,fw):
        n=0
        for c in contents:
            if n%16 == 0:
                fw.write("\n\t.byte\t0x{:x}".format(c))
            else:
                fw.write(",0x{:x}".format(c))
            n += 1
        fw.write("\n")

    music_module_label = f"{gamename}_tunes"

    raw_file = os.path.join(tempfile.gettempdir(),"out.raw")
    with open(sndfile,"w") as fst,open(outfile,"w") as fw:
        fst.write(snd_header)

        fw.write("\t.section\t.datachip\n")
        fw.write("\t.global\t{}\n".format(music_module_label))

        for wav_file,details in sound_dict.items():
            wav_name = os.path.basename(wav_file).lower()[:-4]
            if details.get("channel") is not None:
                fw.write("\t.global\t{}_raw\n".format(wav_name))


        for wav_entry,details in sound_dict.items():
            sound_index = details["index"]

            channel = details.get("channel")
            if channel is None:

                same_as = details.get("same_as")
                if same_as is None:
                    # if music loops, ticks are set to 1 so sound orders only can happen once (else music is started 50 times per second!!)

                    sound_table_set_1[sound_index] = "\t.word\t{},{},{}\n\t.byte\t{},{}".format(2,details["pattern"],0,details["volume"],int(details.get("loops",0)))
                else:
                    # aliased sound: reuse sample for a different sound index
                    wav_entry = same_as
                    details = sound_dict[same_as]
                    wav_name = os.path.basename(wav_entry).lower()[:-4]
                    wav = os.path.splitext(wav_name)[0]
                    sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"
            else:
                wav_name = os.path.basename(wav_entry).lower()[:-4]
                wav_file = os.path.join(sound_dir,wav_name+".wav")

                def get_sox_cmd(sr,output):
                    return [sox,"--volume","3.0",wav_file,"--channels","1","-D","--bits","8","-r",str(sr),"--encoding","signed-integer",output]

                used_sampling_rate = details["sample_rate"]
                used_priority = details.get("priority",1)

                cmd = get_sox_cmd(used_sampling_rate,raw_file)

                subprocess.check_call(cmd)
                with open(raw_file,"rb") as f:
                    contents = f.read()

                # compute max amplitude so we can feed the sound chip with an amped sound sample
                # and reduce the replay volume. this gives better sound quality than replaying at max volume
                # (thanks no9 for the tip!)
                signed_data = [x if x < 128 else x-256 for x in contents]
                maxsigned = max(signed_data)
                minsigned = min(signed_data)

                amp_ratio = max(maxsigned,abs(minsigned))/32

                # JOTD: for that one, I'm using maxxed out sfx by no9, no amp
                print(f"amp_ratio: {amp_ratio}")

                wav = os.path.splitext(wav_name)[0]
                if amp_ratio > 1:
                    print(f"{wav}: volume peaked {amp_ratio}")
                    amp_ratio = 1
                ticks = details.get("ticks")
                if not ticks:
                    ticks = int(len(signed_data)/used_sampling_rate*170)+1  # inflate time (else speech is too fast)
                sound_table[sound_index] = "    SOUND_ENTRY {},{},{},{},{},{},{}\n".format(wav,len(signed_data)//2,channel,
                            used_sampling_rate,int(64*amp_ratio),used_priority,ticks)
                sound_table_set_1[sound_index] = f"\t.word\t1,{int(details.get('loops',0))}\n\t.long\t{wav}_sound"

                if amp_ratio > 0:
                    maxed_contents = [int(x/amp_ratio) for x in signed_data]
                else:
                    maxed_contents = signed_data



                signed_contents = bytes([x if x >= 0 else 256+x for x in maxed_contents])
                # pre-pad with 0W, used by ptplayer for idling
                if signed_contents[0] != b'\x00' and signed_contents[1] != b'\x00':
                    # add zeroes
                    signed_contents = struct.pack(">H",0) + signed_contents

                contents = signed_contents
                # align on 16-bit
                if len(contents)%2:
                    contents += b'\x00'
                # pre-pad with 0W, used by ptplayer for idling
                if contents[0] != b'\x00' and contents[1] != b'\x00':
                    # add zeroes
                    contents = b'\x00\x00' + contents

                fw.write("{}_raw:   | {} bytes".format(wav,len(contents)))

                if len(contents)>65530:
                    raise Exception(f"Sound {wav_entry} is too long")
                write_asm(contents,fw)


        # make sure next section will be aligned
        with open(os.path.join(sound_dir,f"{gamename}_conv.mod"),"rb") as f:
            contents = f.read()

        fw.write("{}:".format(music_module_label))
        write_asm(contents,fw)
        fw.write("\t.align\t8\n")


        fst.writelines(sound_table)
        fst.write("\n\t.global\t{0}\n\n{0}:\n".format("sound_table"))
        for i,st in enumerate(sound_table_set_1):
            fst.write(st)
            fst.write(" | {}\n".format(i))


convert()


