/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/

// #include <stdlib.h>
#include "kernel.h"
char * currentdebugmsg;
char * currentpanicmsg;
void dump() {
    terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(WHITE, BLUE);
	terminal_buffer = (uint16_t*) 0xB8000;
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
    kprintf("\nContents of EAX: ");
    register int eax asm("eax");
    kprinth(eax);
    kprintf("\nContents of EBX: ");
    register int ebx asm("ecx");
    kprinth(ebx);
    kprintf("\nContents of ECX: ");
    register int ecx asm("ecx");
    kprinth(ecx);
    kprintf("\nContents of EDX: ");
    register int edx asm("edx");
    kprinth(edx);

    kprintf("\nContents of stack pointer: ");
    register int esp asm("esp");
    kprinth(esp);
    kprintf("\nContents of stack base pointer: ");
    register int ebp asm("ebp");
    kprinth(ebp);

    kprintf("\nContents of destination: ");
    register int edi asm("edi");
    kprinth(edi);
    setclr(4,BLUE);
    kprintf("\nTry restarting your computer (");
    kprintf(currentdebugmsg);
	kprintf(")");
}
void panic(const char * debug, const char * msg, bool fatal) {
	currentdebugmsg=debug;
	currentpanicmsg=msg;
	setclr(11,0);
	mse_nl();
	kprintf("\nkernel: ");
	setclr(4,0);
	kprintf("panic: error: \"");
	if (fatal==true) {
		setclr(13,0);
		kprintf("fatal: ");
	} else {
		setclr(2,0);
		kprintf("non-fatal: ");
	}
	setclr(12,0);
	kprintf(msg);
	setclr(4,0);
	kprintf("\"");
	mse_nl();
	kprintf("\nDebugging Info:\n\n");
	mse_nl();
	mse_nl();
	setclr(5,0);
	kprintf(debug);
	setclr(4,0);
	if (fatal==true) {
		int i=0;
		while (i<75000000) {
			i++;
			kprintf("\0");
		}
		kprintf("\n\nSending you to dumped data...");
		dump();
        asm volatile("hlt");
		kprintf("abort()\n");
		while (1) { }
		__builtin_unreachable();
	} else {
		kprintf(" Continue on your journey.\n");
		mse_nl();
		mse_nl();
		setclr(15,0);
	}
	
}