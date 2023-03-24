#include "stdio.h"
 
void kernel_main(void) 
{
	term_init();
	/*
	printf colors
		BLACK = 0
		DARK_BLUE = 1
		DARK_GREEN = 2
		DARK_CYAN = 3
		DEEP_RED = 4
		MAGENTA = 5
		BROWN = 6
		LIGHT_GREY = 7
		DARK_GREY = 8
		BLUE = 9
		GREEN = 10
		CYAN = 11
		LIGHT_RED = 12
		LILAC = 13
		YELLOW = 14
		WHITE = 15
	*/
	// for (int i =0;i<16;i++) {
	// 	printf("Hello, kernel World!",i,0);
	// }
	printf("Hello",15);
	printf("World",15);
}