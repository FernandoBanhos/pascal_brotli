set "path=C:\msys64\mingw64\bin"
set "gcc32=gcc.exe"
set "ar32=ar.exe"

if not exist _common mkdir _common
if not exist _enc mkdir _enc
if not exist _dec mkdir _dec

del /Q libbrotli_win64.a
del /Q _common\*.* 2>nul
del /Q _enc\*.* 2>nul
del /Q _dec\*.* 2>nul

%gcc32% -O1 -Iinclude -c common\*.c
move /Y *.o _common\ 
%gcc32% -O1 -Iinclude -c enc\*.c
if exist static_init.o move static_init.o enc_static_init.o
move /Y *.o _enc\
%gcc32% -O1 -Iinclude -c dec\*.c
if exist static_init.o move static_init.o dec_static_init.o
move /Y *.o _dec\

for %%f in (_common\*.o _enc\*.o _dec\*.o) do (
  %ar32% rcs libbrotli_win64.a "%%f"
)