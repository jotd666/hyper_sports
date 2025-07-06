# this script was used once to
# - tag the jump/jsr calls
# - name the jump tables and dump their contents as words in the end of the file
with open("../src/hypersports_6809.asm") as f:
    asm_lines = f.readlines()

with open("rom.bin","rb") as f:
    rom = f.read()

offset = 0x4000
size = 0x100

# first pass: add "jump_table" tag
for i,line in enumerate(asm_lines):
    if "[A," in line and ("JMP" in line or "JSR" in line):
        if "[jump_table]" in line:
            pass
        else:
            line = line.strip() + "        ; [jump_table]\n"
            asm_lines[i] = line

# second pass: find index, then previous LDx instruction to get table address
for i,line in enumerate(asm_lines):
    if "[jump_table]" in line:
        reg = line.split(",")[1][0]
        loadr = "LD"+reg
        dest = None
        for j in range(i-1,i-10,-1):
            other_line = asm_lines[j]
            if loadr in other_line:
                start,dest = other_line.rsplit(None,maxsplit=1)

                break
        if dest:
            if "table_" in dest:
                # already processed, re-process
                dest = dest.replace("table_","")
            table_address = int(dest.strip('#$'),16)
            block = rom[table_address-offset:table_address-offset+size]
            label = f"table_{table_address:04x}"
            asm_lines[j] = f"{start}   #{label}\n"

            asm_lines.append(f"{label}:\n")
            for i in range(0,len(block),2):
                a = block[i]*256 + block[i+1]
                if offset > a or a > 0xCEEE:
                    break
                asm_lines.append(f"\tdc.w\t${a:04x}\t; ${table_address:04x}\n")
                table_address += 2
        else:
            print(f"Could not find {loadr} matching {line}")

with open("../src/hypersports_6809_new.asm","w") as f:
    f.writelines(asm_lines)
