if not exist build64 mkdir build64
cd build64
del /F /Q *.*

rem Compilar todos os arquivos C do Brotli (enc, dec, common)
set CFLAGS=-O2
set GCC=D:\mingw64\bin\gcc.exe
set LD=D:\mingw64\bin\ld.exe
set AR=D:\mingw64\bin\ar.exe

%GCC% %CFLAGS% -c ../c/common/*.c -I../c/include
%GCC% %CFLAGS% -c ../c/enc/*.c -I../c/include
ren static_init.o static_init_enc.o
%GCC% %CFLAGS% -c ../c/dec/*.c -I../c/include
ren static_init.o static_init_dec.o

rem Agrupar tudo num único .a
%LD% -r -o libbrotli_win64.obj *.o
%AR% rcs libbrotli_win64.a *.o
del /F /Q *.o
cd ..