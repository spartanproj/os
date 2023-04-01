go:
	nasm -f elf32 boot/boot.asm -o boot/boot.o
	i686-elf-gcc -m32 -ffreestanding -I/home/werdl/coding/os/bare/libc -c kernel/kernel.c -o kc.o
	ld -m elf_i386 -T boot/link.ld -o kernel.bin boot/boot.o kc.o
run:
	qemu-system-i386 -kernel kernel.bin
	rm -rf boot/boot.o kc.o kasm.o kernel.bin
	rm -rf boot/boot.o kc.o kasm.o kernel.bin