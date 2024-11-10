#!/bin/bash
set -x

rm getflag
rm data.o
rm flag.o

nasm -f elf64 -F dwarf -o flag.o myAssem.asm
nasm -f elf64 -F dwarf -o data.o mydata.asm

ld flag.o data.o -o exeIt

set +x

chmod +x exeIt
./exeIt
echo $?


