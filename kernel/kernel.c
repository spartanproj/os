#include <kernel/idt.h>
#include <stdio.h>
#include <util.h>
#include <stdbool.h>
#include "keys.h"
#include <random/rand.h>
#include "games/tic.c"
#include "util/ascii.h"
#include "games/21.c"
#include <fs/fs.h>

char * history;
int counter=0;
bool printrn=false;
int x_gui = 0;
int y_gui =0;
char * typed[1024];
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
		} else if (keys(keycode)=="BKSP") {
			for (int y=0;y<1024;y++) {
				typed[y]="";
			}
			return;
		}else {
			typed[counter]=keys(keycode);
			counter++;
			const char * key=keys(keycode);
			
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
		if (printrn==true) {
			printf(keys(keycode));
			printf(" - hex value - 0x");
			char buffer[15];
			itoa(keycode,buffer,10);
			printf(buffer);
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
extern char read_port(unsigned short port);
extern void write_port(unsigned short port, unsigned char data);
bool sudo=false;
bool quitgui=false;
int kmain(void)
{
	for (int y=0;y<1024;y++) {
		typed[y]="";
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
	printf("\n");
	printf(info.contents);

	int i=0;
	while (i<75000000) {
		i++;
		printf("\0");
	}
	
	clear();
	kprintd("Boot into kernel: ",1);
	idt_init();
	kb_init();
	fsinit();
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
	char * user="bob";
	printf("Logged in as ");
	printf(user);
	printf("\n");
	// char buff[15];
	// srand(rnd);
	// itoa(rand(),buff,10);
	// printf(buff);
	srand(rnd);
	printf("Debugging ON or OFF?\n");
	bool q=true;
	bool playing=false;
	int toss;
	while(1){
		if (typed[0]=="o" && typed[1]=="n" && q==true && typed[2]=="ENTER") {
			q=false;
			printrn=true;
			printf("Ok, debugging on!\n");
			mse_nl();
			toclear=true;
		} else if (typed[0]=="o" && typed[1]=="f" && typed[2]=="f" && typed[3]=="ENTER" && q==true) {
			q=false;
			printf("Ok, no debugging\n");
			mse_nl();
			toclear=true;
		}
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
				break;
				return 0;
			} else {
				printf("You no sudo...\n");
			} toclear=true;
		} else if (typed[0]=="g" && typed[1]=="u" && typed[2]=="i" && typed[3]=="ENTER") {
			printf("Boot into text based GUI");
			toclear=true;
			gui();
		} else if (typed[0]=="q" && typed[1]=="ENTER") {
			quitgui=true;
			toclear=true;
		} else if (typed[0]=="e"&&typed[1]=="d"&&typed[2]=="i"&&typed[3]=="t"&& typed[4]=="ENTER") {
			text_edit();
			toclear=true;
		} else if (typed[0]=="t" && typed[1]=="i" && typed[2]=="c" && typed[3]=="ENTER") {
			tic();
			toclear=true;
			printf("\n\n");
			setclr(10,0);
			printf("Type your commands below.\n");
			mse_nl();
			setclr(15,0);
		}
		else if (typed[0]=="L-CTRL"&&typed[1]=="L-ALT"&& typed[2]=="t") {
			panic("end","hlt",1);
			break;
		}  else if (typed[0]=="r" && typed[1]=="a" && typed[2]=="n" && typed[3]=="d" && typed[4]=="ENTER") {
			char buff[15];
			itoa(rand(),buff,10);
			printf(buff);
			printf("\n");
			toclear=true;
		} else if (typed[0]=="c" && typed[1]=="o" && typed[2]=="i" && typed[3]=="n" && typed[4]=="ENTER") {
			playing=true;
			toss=rand()%2;
			
			printf("Enter your number (0 or 1)\n");
			toclear=true;
		} else if (typed[0]=="0" && typed[1]=="ENTER" && playing==true) {
			setclr(5,0);
			printf("toss was....\n");
			printn(toss);
			printf("\n");
			setclr(15,0);
			if(toss==0) {
				printf("You win! Good job!\n");
				playing=false;
			} else {
				printf("Not this time...\n");
				playing=false;
			}
			toclear=true;
		} else if (typed[0]=="1" && typed[1]=="ENTER" && playing==true) {
			setclr(5,0);
			printf("toss was....\n");
			printn(toss);
			printf("\n");
			setclr(15,0);
			if(toss==1) {
				printf("You win! Good job!\n");
				playing=false;
			} else {
				printf("Not this time...\n");
				playing=false;
			}
			toclear=true;
			
		} else if (typed[0]=="h" && typed[1]=="i" && typed[2]=="s" && typed[3]=="ENTER") {
			printf("hi");
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
			while (1) {
				if (typed[0]=="3"){
					printf("hi");
					break;
				}
			}
			toclear=true;
		} else if (typed[0]=="2" && typed[1]=="1"&& typed[2]=="ENTER") {
			int lastnum=comp(0);
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
			int typedno=0;
			while (1) {
				if (typed[0]=="0") {
					break;
				} else if (typed[0]!="\0"){
					typedno++;
					lastnum++;
					for (int y=0;y<1024;y++) {
						typed[y]="\0";
					}
				}
				if (typedno>=3) {
					typedno=0;
					break;
				}
			}
			int x;
			while (lastnum<21) {
				lastnum=comp(lastnum);
				while (1) {
					if (typed[0]=="0") {
						break;
					} else if (typed[0]!="\0"){
						typedno++;
						lastnum++;
						for (int y=0;y<1024;y++) {
							typed[y]="\0";
						}
					}
					if (typedno>=3) {
						typedno=0;
						break;
					}
				}
				printn(lastnum);
				break;
				if (lastnum>=21) {break;}
			}
			printf("hmm");
			toclear=true;

			toclear=true;
		} else if (typed[0]=="i" && typed[1]=="n" && typed[2]=="f" && typed[3]=="o" && typed[4]=="ENTER") {
			printf("\n");
			printf(info.contents);
			toclear=true;
		}
		if (toclear==true) {
			toclear=false;
			for (int y=0;y<1024;y++) {
				typed[y]="\0";
			}
		}
		}
	
}
int gui() {
	clear_screen();
	clear();
	setclr(15,15);
	for (int r=0;r<12;r++) {
		setclr(15,15);
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
	}
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
		setclr(15,0);
		printf("hi");
		setclr(15,15);
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
	for (int r=0;r<13;r++) {
		setclr(15,15);
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
	}
	if (quitgui==true) {
		clear();
		clear_screen();
		return 0;
	}
}
int text_edit() {
	clear_screen();
	clear();
	setclr(10,0);
	printf(" ~\n");
	mse_nl();
	setclr(15,0);
}