CFLAGS=
go:
	libc/random/rand.sh libc/random/rand
	nasm -f elf32 boot/boot.asm -o boot/boot.o
	$(HOME/opt/cross/bin/$TARGET)-gcc -m32 -ffreestanding -Ilibc -c kernel/kernel.c -o kc.o $(CFLAGS)
	ld -m elf_i386 -T boot/link.ld -o kernel.bin boot/boot.o kc.o
run:
	qemu-system-i386 -kernel kernel.bin
clean:
	rm -rf boot/boot.o kc.o kasm.o kernel.bin
	rm -rf boot/boot.o kc.o kasm.o kernel.bin
game:
	gcc games/main.c -o main.gcc.out -g 

	./main.gcc.out
gclean:
	rm -rf main.gcc.out 21.gcc.out
21:
	gcc games/21.c -o 21.gcc.out -g
	./21.gcc.out
