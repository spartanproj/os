#include <kernel/idt.h>
#include <stdio.h>
#include <util.h>
#include <stdbool.h>
#include "keys.h"
char * typed[1024];
int counter=0;
bool printrn=false;
int x_gui = 0;
int y_gui =0;
char * position[3][3]={{"0,0","1,0","2,0"},
					   {"0,1","1,1","2,1"},
					   {"0,2","1,2","2,2"}}; // which gui box you are on
void keyboard_handler_main(void)
{
	unsigned char status;
	char keycode;
	write_port(0x20, 0x20);

	status = read_port(KEYBOARD_STATUS_PORT);
	if (status & 0x01) {
		keycode = read_port(KEYBOARD_DATA_PORT);
		if(keycode < 0)
			return;

		else if(keycode == ENTER_KEY_CODE) {
			mse_nl();
			printf("\n");
			typed[counter]="ENTER";
			counter=0;
			return;
		} else {
			typed[counter]=keys(keycode);
			counter++;
			const char * key=keys(keycode);
			if (printrn==true) {
				printf(key);
			}
			if(!move(key)) {
				printf("\n");
				printf(prnt(x_gui));
				printf(",");
				printf(prnt(y_gui));
				printf("\n");
				printf(position[y_gui][x_gui]);
				mse_nl();
				mse_nl();
				mse_nl();

			}
			// printf(typed[0]);
			// printf(typed[1]);
		} 
		setclr(7,0);
		printf(keys(keycode));
		setclr(15,0);
	}
}
int move(const char * inp) {
	bool fail=false;
	bool up=true;
	bool down=true;
	bool left=true;
	bool right=true;
	
	int old_y=y_gui;
	int old_x=x_gui;
	if (y_gui>=2) {
		up=false; // 1 for maximum
	} else if(y_gui<=0) {
		down=false;
	} if(x_gui>=2) {
		right=false;
	} else if (x_gui<=0) {
		left=false;
	}
	if (inp=="UP" && up==true) y_gui++; 
	else if (inp=="DOWN" && down==true) y_gui--;
	else if (inp=="RIGHT" && right==true) x_gui++;
	else if (inp=="LEFT" &&left==true) x_gui--;
	else fail=true;
	return -fail; // 0 for great, -1 for error
}
bool sudo=false;
void kmain(void)
{
	for (int y=0;y<1024;y++) {
		typed[y]="\0";
	}
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
	printf("\n / _ \\               |  _  | / ___| |  _  |/  ___|\n/ /_\\ \\ _ __   __  __ \\ V / / /___  | | | |\\ `--. \n|  _  || '_ \\  \\ \\/ / / _ \\ | ___ \\ | | | | `--. \n| | | || | | |  >  < | |_| || \\_/ | \\\\_/ //\\__/ /\n\\_| |_/|_| |_| /_/\\_\\_____/\\_____/  \\___/ \\____/ ");
	setclr(15,0);
	printf("\n\n\nWelcome to NerdOS. Enjoy your stay :)");
	int i=0;
	while (i<50000000) {
		i++;
		printf("\0");
	}
	
	clear();
	kprintd("Boot into kernel: ",1);

	idt_init();
	kb_init();
	nprintf("\n");
	kprintd("Initialise IDT and keyboard input: ",1);
	mse_nl();
	mse_nl();
	printf("\n");
	setclr(10,0);
	printf("Type your commands below.\n");
	mse_nl();
	setclr(15,0);
	printrn=false;
	bool toclear=false;
	while(1){
		if (typed[0]=="e" && typed[1]=="c" && typed[2]=="ENTER"){ 
			printf("HI!");
			mse_nl();
			printf("\n");
			counter=0;
			toclear=true;
		} else if 
(typed[0]=="e" && typed[1]=="c"&&typed[2]=="h"&&typed[3]=="o" && typed[4]=="ENTER") {
			for (int k=5;typed[k]!="\0"&&typed[k]!="ENTER";k++) {
				printf(typed[k]);
			}
			// printf("hello from echo!");
			mse_nl();
			printf("\n");
			counter=0;
			toclear=true;
		} else if (typed[0]=="l" && typed[1]=="o"&&typed[2]=="g"&&typed[3]=="i" && typed[4]=="n" &&typed[5]==" " && typed[6]=="p" && typed[7]=="a"&&typed[8]=="s"&&typed[9]=="s"&&typed[10]=="ENTER") {
			printf("Logged in as sudo\n");
			mse_nl();
			sudo=true;
			toclear=true;
		} else if(typed[0]=="h"&&typed[1]=="l"&&typed[2]=="t"&&typed[3]=="ENTER") {
			if (sudo==true) {
				printf("HALTING");
				panic("processes halted by sudo","hlt",1);
				return 0;
			} else {
				printf("You no sudo...\n");
			} toclear=true;
		}
		if (toclear==true) {
			toclear=false;
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
		}
		}
	
}