# PlaatOS - Made by Bastiaan van der Plaat
nasm -f bin boot.asm -o boot.bin
cat boot.bin > plaatos.bin
nasm -f bin kernel.asm -o kernel.bin
cat kernel.bin >> plaatos.bin
nasm -f bin hello.asm -o hello.bin
cat hello.bin >> plaatos.bin
qemu-system-i386 -L "C:\Program Files\qemu" -fda plaatos.bin
