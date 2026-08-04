set "path=C:\msys64\mingw32\bin"
set "gcc32=gcc.exe"
set "ar32=ar.exe"

del /Q libbrotli_win32.a
del /Q _common\*.*
del /Q _enc\*.*
del /Q _dec\*.*

%gcc32% -O2 -Iinclude -c common\*.c
move /Y *.o _common\ 
%gcc32% -O2 -Iinclude -c enc\*.c
move static_init.o enc_static_init.o
move /Y *.o _enc\
%gcc32% -O2 -Iinclude -c dec\*.c
move static_init.o dec_static_init.o
move /Y *.o _dec\

for %%f in (_common\*.o _enc\*.o _dec\*.o) do (
  %ar32% rcs libbrotli_win32.a "%%f"
)