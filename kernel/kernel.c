#include "stdio.h"
#include "abort.h" //stdio here also
#include "kernel.h"
void kernel_main(void) 
{
	term_init();
	/*
	setclr colors
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
	setclr(2,0);
	printf(" _   _                  _  _____  _____           \n| \\ | |                | ||  _  |/  ___|          \n|  \\| |  ___  _ __   __| || | | |\\ `--.           \n| . ` | / _ \\| '__| / _` || | | | `--. \\          \n| |\\  ||  __/| |   | (_| |\\ \\_/ //\\__/ /          \n\\_| \\_/ \\___||_|    \\__,_| \\___/ \\____/           \n\n\n  ___                 _____   ____   _____  _____ ");
	printf("\n / _ \\               |  _  | / ___| |  _  |/  ___|\n/ /_\\ \\ _ __   __  __ \\ V / / /___  | | | |\ `--. \n|  _  || '_ \\  \\ \\/ / / _ \\ | ___ \\ | | | | `--. \n| | | || | | |  >  < | |_| || \\_/ | \\\\_/ //\\__/ /\n\\_| |_/|_| |_| /_/\\_\\_____/\\_____/  \\___/ \\____/ ");
	setclr(15,0);
	printf("\n\n\nWelcome to NerdOS. Enjoy your stay :)");
	int i=0;
	while (i<100000000) {
		i++;
		printf("\0");
	}
	clear();
	kprintd("Boot into kernel:",1);
	
}