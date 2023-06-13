
// #include <stdlib.h>
#include "kernel.h"
void dump();
char * currentdebugmsg;
char * currentpanicmsg;
void panic(const char * debug, const char * msg, bool fatal) {
	currentdebugmsg=debug;
	currentpanicmsg=msg;
	setclr(11,0);
	mse_nl();
	printf("\nkernel: ");
	setclr(4,0);
	printf("panic: error: \"");
	if (fatal==true) {
		setclr(13,0);
		printf("fatal: ");
	} else {
		setclr(2,0);
		printf("non-fatal: ");
	}
	setclr(12,0);
	printf(msg);
	setclr(4,0);
	printf("\"");
	mse_nl();
	printf("\nDebugging Info:\n\n");
	mse_nl();
	mse_nl();
	setclr(5,0);
	printf(debug);
	setclr(4,0);
	if (fatal==true) {
		int i=0;
		while (i<75000000) {
			i++;
			printf("\0");
		}
		printf("\n\nSending you to dumped data...");
		dump();
        asm volatile("hlt");
		printf("abort()\n");
		while (1) { }
		__builtin_unreachable();
	} else {
		printf(" Continue on your journey.\n");
		mse_nl();
		mse_nl();
		setclr(15,0);
	}
	
}