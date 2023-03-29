
// #include <stdlib.h>
 #include "kernel.h"
void abort(const char* debug, const char* msg) {
	setclr(11,0);
	printf("\nkernel: ");
	setclr(4,0);
	printf("panic: error: \"");
	setclr(12,0);
	printf(msg);
	setclr(4,0);
	printf("\"");
	printf("\nDebugging Info:\n\n");
	setclr(5,0);
	printf(debug);
	setclr(4,0);
	printf("\n\nHalting proccesses (sorry).");
        asm volatile("hlt");
	printf("abort()\n");
	while (1) { }
	__builtin_unreachable();
}