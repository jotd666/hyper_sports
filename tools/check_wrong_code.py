import os,re

# post-processing checker design to find parts which were wrongly converted by 6809to68k version
# prior to v1.1 (not versionned at the time)

this_dir = os.path.dirname(os.path.abspath(__file__))

jere = re.compile(r"\s+OP_R_ON_DP_ADDRESS.*: ([la]s[lr]|ro[lr])",flags=re.I)

with open(os.path.join(this_dir,"..","src","hyper_sports.68k")) as f:
    lines = list(f)


for line in lines:
    m = jere.match(line)
    if m:
        print("wrong conversion: {}".format(line.rstrip()))
