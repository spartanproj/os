/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
#include <kernel/idt.h> // IDT
#include <stdio.h> // printf and tty
#include <util.h> // various wrappers, atoi, itoa
#include <stdbool.h> // compiler gen, bool
#include "keys.h" // keymap
#include <random/rand.h> // compile-time random
#include "games/tic.c" // tic tac toe
#include "util/ascii.h" // ascii art at boot
#include "games/21.c" // WIP 21 game
#include <fs/fs.h> // journals
#include <time/time.h> // wrappers for time
// #include <file/file.h> failed file implementation
#include <const.h> // BlueberryOS constants
#include <mem/alloc.h> // kmalloc
#include <mem/memcmp.h> // memcmp
#include <file/fs_struct.h> // filesystem structs and funcs
#include <file/initrd.h> // compiler generated file
#include "util/splash.h" // generate random splash
#include <sys/cpuid.h> // cpuid utils
#include <blueberry.h> // consts
#include <io/clr.h> // clrs
#include "util/asciigen.h" // file python generates for me, contains ASCII art. Wrote a little helper script that takes a .png as input (usually 16x16) then outputs it as setclr and printf calls.
//#include "util/cmd.h" // checktype()
// cmd.h is included is on line 257, so constants from this file are accessible.
int gui();
int text_edit();
int move(const char * inp);
void checktype();
int dellast();
char * history;
int counter=0;
bool printrn=false;
bool debug=WARN;
int x_gui = 0;
int y_gui = 0;
int cmdstyped = 0;
char * typed[1024];
char * previoustyped[1024];
char typed2[1024];
char * position[3][3]={{"0,0","1,0","2,0"},
					   {"0,1","1,1","2,1"},
					   {"0,2","1,2","2,2"}}; // which gui box you are on

void keyboard_handler_main(void)
{
	createfiles(); //function call from initrd.h
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
			memcpy(previoustyped,typed,1024);
			typed[counter]="ENTER";
			checktype();
			for (int it=0;it<1024;it++) {
				typed[it]="\0";
			}
			counter=0;
			return;
		} else if (keys(keycode)=="BKSP") {
			dellast();
			terminal_column--;
			write_to(' ', terminal_color, terminal_column, terminal_row);
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
		setclr(deftype(),0);
		printf(keys(keycode));
		setclr(defcol(),0);
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
// two assembly routines, defined in boot/boot.asm
bool sudo;

bool quitgui=false;

int kmain(void)
{
	createfiles();
	srand(rnd);
	if (search("user.conf")=="root") {sudo=true;}
	else {sudo=false;}
	if (search("user.conf")=="") {
		panic("user.conf instantiated to empty string","No user set",1);
	}
	for (int y=0;y<1024;y++) {
		typed[y]="";
	}
	term_init();

	generatedart();
	setclr(13,0);
	printf("Welcome to BlueberryOS. Enjoy your stay :)");
	if (WARN && sudo) {
		setclr(12,0);
		printf("    Caution: you are running as root.\n");
	} else {
		printf("\n");
	}
	setclr(11,0);
	printdate();
	char * splasht=splash();
	setclr(random_number_splash==10||random_number_splash==3?14:3,0);
	printf(splasht);
	setclr(defcol(),0);
	printf("\n");
	printf("__blueberry__==");
	printf(__blueberry__?"true\n":"false\n");
	printf(info.contents);
	sleep(strlen(splasht)/3);

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
	kprintd("Get initrd: ",1);
	printf("\n");
	kprintd("srand(): ",1);
	printf("\n");
	mse_nl();
	setclr(10,0);
	printf("Type your commands below.\n");
	mse_nl();
	setclr(defcol(),0);
	printrn=false;
	debug=false;

	printf("Logged in as \"");
	printf(search("user.conf"));
	printf("\"\n");
	// char buff[15];
	// srand(rnd);
	// itoa(rand(),buff,10);
	// printf(buff);

	printf("Debugging ON (keylogger), OFF or SOME (warnings)?\n");

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
		checktype();
	}
	
}
#include "util/cmd.h" // checktype()
int gui() {
	clear_screen();
	clear();
	setclr(defcol(),15);
	for (int r=0;r<12;r++) {
		setclr(defcol(),15);
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
	}
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
		setclr(defcol(),0);
		printf("hi");
		setclr(defcol(),15);
		printf("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
	for (int r=0;r<13;r++) {
		setclr(defcol(),15);
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
	setclr(defcol(),0);
}
