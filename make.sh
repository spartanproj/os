if i686-elf-gcc -c kernel/kernel.c -o kernel/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra; then
    echo "KERNEL: COMPILED"
else
    echo "KERNEL: FAILED"
    echo "ABORTING"
    exit 1
fi
if i686-elf-gcc -T boot/linker.ld -o os.bin -ffreestanding -O2 -nostdlib boot/boot.o kernel/kernel.o -lgcc; then
    echo "LINKING: YES"
else
    echo "LINKING: FAILED"
    echo "ABORTING"
fi
qemu-system-i386 -kernel os.bin

if rm -rf kernel/kernel.o os.bin; then
    echo "CLEANED: YES"
    exit 0
else   
    echo "CLEANED: NO"
    exit 1
fi