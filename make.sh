i686-elf-gcc -c kernel/kernel.c -o kernel/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T boot/linker.ld -o os.bin -ffreestanding -O2 -nostdlib boot/boot.o kernel/kernel.o -lgcc
qemu-system-i386 -kernel os.bin
rm -rf kernel/kernel.o
rm -rf os.bin