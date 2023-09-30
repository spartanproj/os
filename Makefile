CFLAGS=-Wno-stringop-overflow -Wno-discarded-qualifiers

go: | prep elfgcc run

prep:
	nasm -f elf32 boot/boot.asm -o boot/boot.o
elfgcc:| prep	
	i686-elf-gcc -m32 -ffreestanding -Ilibc -c kernel/kernel.c -o kc.o $(CFLAGS)
	i686-elf-ld -m elf_i386 -T boot/link.ld -o kernel.bin boot/boot.o kc.o
run:
	qemu-system-i386 -rtc base=localtime -kernel kernel.bin
cmdrun: 
	qemu-system-i386 -rtc base=localtime -curses -kernel kernel.bin
clean:
	rm -rf boot/boot.o kc.o kasm.o kernel.bin kernel.img intl libcody libdecnumber libiberty serdep.tmp zlib a.out config.log config.status libbacktrace lto-plugin kernel/util/clr.py kernel/util/asciigen.h
normalgcc:| prep	
	gcc -w -m32 -ffreestanding -Ilibc -c kernel/kernel.c -o kc.o $(CFLAGS)
	ld -m elf_i386 -T boot/link.ld -o kernel.bin boot/boot.o kc.o
term:| normalgcc cmdrun clean
nothing:
