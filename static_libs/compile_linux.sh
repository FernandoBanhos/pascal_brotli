#!/bin/bash
set -e

GCC=gcc
AR=ar

mkdir -p _common _enc _dec

rm -f libbrotli_linux64.a
rm -f _common/* _enc/* _dec/* *.o

# Compila common
$GCC -O1 -Iinclude -c common/*.c
mv -f *.o _common/

# Compila enc
$GCC -O1 -Iinclude -c enc/*.c
if [ -f static_init.o ]; then
    mv -f static_init.o enc_static_init.o
fi
mv -f *.o _enc/

# Compila dec
$GCC -O1 -Iinclude -c dec/*.c
if [ -f static_init.o ]; then
    mv -f static_init.o dec_static_init.o
fi
mv -f *.o _dec/

# Cria a biblioteca estática
$AR rcs libbrotli_linux64.a _common/*.o _enc/*.o _dec/*.o

echo "Biblioteca criada: libbrotli_linux64.a"