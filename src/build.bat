@echo off
cd /D %~pd0
echo %CD%
call full_convert.bat
wmake.py -m ..\makefile.am

