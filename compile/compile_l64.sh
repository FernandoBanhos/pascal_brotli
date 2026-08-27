mkdir -p buildlinux && cd buildlinux

CFLAGS="-O2 -fPIC" 
gcc -c ../c/common/*.c -I../c/include
gcc -c ../c/enc/*.c -I../c/include
gcc -c ../c/dec/*.c -I../c/include

ar rcs libbrotli_linux64.a *.o