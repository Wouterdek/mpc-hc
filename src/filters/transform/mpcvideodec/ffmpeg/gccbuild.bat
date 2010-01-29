@echo off
if NOT "x%MINGW32%" == "x" goto Var1Ok
echo "ERROR : please define MINGW32 (and/or MSYS) environment variable(s)"
exit 1005

:Var1Ok
rem if NOT "x%CC%" == "x" goto Var2Ok
rem echo "ERROR : please define CC environment variable"
rem exit 1005

:Var2Ok
set CC=gcc.exe
set PATH=%MSYS%\bin;%MINGW32%\bin;%YASM%;%PATH%

IF "%1%"=="rebuild" goto DoClean
IF "%1%"=="clean" goto OnlyClean
goto NoClean

:OnlyClean
make.exe clean
IF EXIST 64bit.build rm 64bit.build
goto End

:DoClean
make.exe clean
IF EXIST 64bit.build rm 64bit.build

:NoClean
IF NOT EXIST 64bit.build GOTO NoArchClean
make.exe clean
rm 64bit.build

:NoArchClean
touch 32bit.build
make.exe -j4

:End
