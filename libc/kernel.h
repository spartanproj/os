#ifdef stdio.h
#include "stdio.h"
#endif

void kprintf(const char* msg) {
    setclr(11,0);
    printf("kernel: ");
    setclr(15,0);
    printf(msg);
}