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
#include <time/time.h>
#include <file/file.h>
int gui();
int text_edit();
int move(const char * inp);
char * history;
int counter=0;
bool printrn=false;
bool debug=false;
int x_gui = 0;
int y_gui = 0;
int cmdstyped = 0;
char * typed[1024];
char typed2[1024];
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
			if (currentnode==9) {
				if (debug) {
					printf("Warning: Journal entries being overwritten\n");
				}	
				currentnode=0;
			} else {
				currentnode++;
			}
			cmdstyped++;
			typed[counter]="ENTER";
			counter=0;
			return;
		} else if (keys(keycode)=="BKSP") {
			for (int y=0;y<1024;y++) {
				typed[y]="";
			}
			return;
		} else {
			typed[counter]=keys(keycode);
			counter++;
			const char * key=keys(keycode);
			writefs(keys(keycode),'a',currentnode);
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
int dellast() {
	typed[counter]="\0";
	counter--;
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
	setclr(13,0);
	printf("\n\n\n Welcome to NerdOS. Enjoy your stay :)\n");
	setclr(11,0);
	printdate();
	setclr(15,0);
	printf("Please ignore slow boot time, it hangs on a while loop! It may be due to the \nspeed of your computer\n");
	printf("\n");
	printf(info.contents);

	sleep(3);
	
	clear();
	kprintd("Boot into kernel: ",1);
	printf("\n");
	idt_init();
	kb_init();
	kprintd("Initialise IDT and keyboard input: ",1);
	mse_nl();
	mse_nl();
	printf("\n");
	fsinit();
	kprintd("Initialise journaling: ",1);
	printf("\n");
	mse_nl();
	setclr(10,0);
	printf("Type your commands below.\n");
	mse_nl();
	setclr(15,0);
	writ("hi","hello");
	writ("hmmmmmm","klkl");
	printf(read("klkl"));
	printrn=false;
	debug=false;
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
	printf("Debugging ON, OFF or SOME?\n");
	bool q=true;
	bool playing=false;
	int toss;
	int ucounter=0;
	writefs("",'w',0);
	writefs("",'w',1);
	writefs("",'w',2);
	writefs("",'w',3);
	writefs("",'w',4);
	writefs("",'w',5);
	writefs("",'w',6);
	writefs("",'w',7);
	writefs("",'w',8);
	writefs("",'w',9);
	while(1){
		if (typed[0]=="o" && typed[1]=="n" && q==true && typed[2]=="ENTER") {
			q=false;
			printrn=true;
			debug=true;
			printf("Ok, debugging on!\n");
			mse_nl();
			toclear=true;
		} else if (typed[0]=="o" && typed[1]=="f" && typed[2]=="f" && typed[3]=="ENTER" && q==true) {
			q=false;
			printf("Ok, no debugging\n");
			mse_nl();
			toclear=true;
		} else if (typed[0]=="s" && typed[1]=="o" && typed[2]=="m" && typed[3]=="e" && typed[4]=="ENTER" && q==true){
			printf("Ok, some debugging on!\n");
			mse_nl();
			q=false;
			debug=true;
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
			printf(root.o0.contents);
			printf(" ");
			printf(root.o1.contents);
			printf(" ");
			printf(root.o2.contents);
			printf(" ");
			printf(root.o3.contents);
			printf(" ");
			printf(root.o4.contents);
			printf(" ");
			printf(root.o5.contents);
			printf(" ");
			printf(root.o6.contents);
			printf(" ");
			printf(root.o7.contents);
			printf(" ");
			printf(root.o8.contents);
			printf(" ");
			printf(root.o9.contents);
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
		} else if (typed[0]=="w" && typed[1]=="r" && typed[2]=="i" && typed[3]=="t" && typed[4]=="ENTER") {
			int up=strnum(typed[5]);
			writefs("",'a',up);
			for (int k=6;typed[k]!="\0"&&typed[k]!="ENTER";k++) {
				writefs(typed[k],'a',up);
			}
			printf("Done!");
			mse_nl();
			printf("\n");
			toclear=true;
		} else if (typed[0]=="r" && typed[1]=="e" && typed[2]=="a" && typed[3]=="d" && typed[5]=="ENTER") {
			char buffe[1024];
			bool yes=true;
			if (typed[4]=="0") printf(root.o0.contents);
			else if (typed[4]=="1") printf(root.o1.contents);
			else if (typed[4]=="2") printf(root.o2.contents);
			else if (typed[4]=="3") printf(root.o3.contents);
			else if (typed[4]=="4") printf(root.o4.contents);
			else if (typed[4]=="5") printf(root.o5.contents);
			else if (typed[4]=="6") printf(root.o6.contents);
			else if (typed[4]=="7") printf(root.o7.contents);
			else if (typed[4]=="8") printf(root.o8.contents);
			else if (typed[4]=="9") printf(root.o9.contents);
			else {yes=false;}
			if (yes==true) {
				printf("\n");
			}
			toclear=true;
			
		} else if (typed[0]=="d" && typed[1]=="u" && typed[2]=="m" && typed[3]=="p" && typed[4]=="ENTER") {
			dump();
			toclear=true;
		} else if (typed[0]=="p" && typed[1]=="a" && typed[2]=="n" && typed[3]=="i" && typed[4]=="c" && typed[5]=="ENTER" ) {
			panic("Testing purposes.","Initiated by user",1);
		} else if (typed[0]=="t" && typed[1]=="i" && typed[2]=="m" && typed[3]=="e" && typed[4]=="ENTER") {
			printdate();
			toclear=true;
		} else if (typed[0]=="s" && typed[1]=="l" && typed[2]=="e" && typed[3]=="e" && typed[4]=="p" && (typed[7]=="ENTER" || typed[8]=="ENTER")) {
			char buffer[10];
			memcpy(buffer,typed[6],3);
			int buf7=0;
			int buf6=atoi(typed[6])*10;
			if (typed[7]!="ENTER") {
				buf7=atoi(typed[7]);
			} else {
				buf6=atoi(typed[6]);
			}
			int time=buf6+buf7;
			printn(time);
			for (int t=time-1;t>0;t--) {
				sleep(1);
				printn(t);
			}
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