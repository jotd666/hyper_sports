import subprocess,os,glob,shutil,pathlib

progdir = pathlib.Path(os.path.abspath(os.path.join(os.path.dirname(__file__),os.pardir)))

gamename = "hyper_sports"
# JOTD path for cranker, adapt to whatever your path is :)
os.environ["PATH"] += os.pathsep+r"K:\progs\cli"

cmd_prefix = ["make","-f",progdir/"makefile.am"]

subprocess.check_call(cmd_prefix+["clean"],cwd=progdir / "src")

subprocess.check_call(cmd_prefix+["RELEASE_BUILD=1"],cwd=progdir / "src")
# create archive

outdir = progdir / f"{gamename}_HD"

if os.path.exists(outdir):
    for x in outdir.glob("*"):
        x.unlink()
else:
    outdir.mkdir()
for file in ["readme.md",f"{gamename}_AGA.slave",f"{gamename}_ECS.slave"]:
    shutil.copy(progdir / file,outdir)

for file in (progdir / "assets" / "amiga").glob("*.info"):
    shutil.copy(file,outdir)



for suffix in ["ecs","aga"]:
    exename = f"{gamename}_{suffix}"
    shutil.copy(progdir/exename,outdir)
    subprocess.check_output(["cranker_windows.exe","-f",progdir/exename,"-o",progdir/f"{exename}.rnc"])

subprocess.check_call(cmd_prefix+["clean"],cwd=progdir/"src")
