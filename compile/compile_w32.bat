if not exist build32 mkdir build32 
cd build32
del /F /Q *.*

rem Compilar todos os arquivos C do Brotli (enc, dec, common)
set CFLAGS=-O2
set GCC=D:\mingw32\bin\gcc.exe
set AR=D:\mingw32\bin\ar.exe

%GCC% %CFLAGS% -c ../c/common/*.c -I../c/include
%GCC% %CFLAGS% -c ../c/enc/*.c -I../c/include
ren static_init.o static_init_enc.o
%GCC% %CFLAGS% -c ../c/dec/*.c -I../c/include
ren static_init.o static_init_dec.o

rem Agrupar tudo num único .a
%AR% rcs libbrotli_win32.a *.o
../objconv.exe -fomf libbrotli_win32.a libbrotli_win32.obj
del /F /Q *.o
cd ..