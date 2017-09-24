@echo off

echo./*
echo.* Check VC++ environment...
echo.*/
echo.

if defined VS150COMNTOOLS (
    set VSVARS="%VS150COMNTOOLS%\VsDevCmd.bat"
)

if not defined VSVARS (
    echo Can't find VC2017 installed!
    goto ERROR
)

call %VSVARS%

cd src
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL l*.c
del lua.obj luac.obj
link /DLL /out:lua53.dll l*.obj
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL lua.c luac.c
link /out:lua.exe lua.obj lua53.lib
del lua.obj
link /out:luac.exe l*.obj
del *.obj
del *.exp
cd ..

:ERROR
pause