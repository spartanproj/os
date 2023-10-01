#include <stdbool.h> // compiler
#include <stddef.h> // compiler
#include <stdint.h> // compiler
#include <kernel/idt.h> // more keyboard
#include <stdio.h> // vkprintf kprintf putchar
#include <util.h> // various (itoa etc)
#include <mem/alloc.h> // kmalloc
#include <mem/memcmp.h> // memcmp
#include <mem/memcpy.h> // memcpy
#include <io/clr.h> // colors
#include "keyboard.h" // keyboard map
#include <sys/time.h> // timing
#include <io/util.h> // comparison functions
#include <sys/ssp.h> // stack smash protector
#include <kernel/io/cmds.h> // cmd callbacks
#include "kinit.c" // kernel init, called before kmain

int counter=0; // counts how many keys have been pressed
char typed[1024]; // holds current line of keyboard input
char just_typed[1024]; // holds input that was typed before enter was pressed
void dellast(void) {
    // deletes last character from working keyboard memory
    typed[counter]='\0';
    counter--;
}
void keyboard_handler_main(void) {
    // handles keyboard input, called by boot.asm
    unsigned char status;
    char keycode;
    write_port(0x20, 0x20);

    status = read_port(KEYBOARD_STATUS_PORT);
    if (status & 0x01) {
        keycode = read_port(KEYBOARD_DATA_PORT);
        if(keycode<0)
            return;
        else if(keycode==ENTER_KEY_CODE) {
            kprintf("\n");                  // checktype();
            terminal_column--;
            for (int it=0;it<1024;it++) {
                    just_typed[it]='\0';
            }
            memcpy(just_typed,typed,1024);
            for (int it=0;it<1024;it++) {
                    typed[it]='\0';
            }
            counter=0;
            return;
        } else if (keys(keycode)=='`') {
            dellast();
            terminal_column--;
            write_to(' ', terminal_color, terminal_column, terminal_row);
            return;
        } else {
            typed[counter]=keys(keycode);
            counter++;
            const char key=keys(keycode);
        } 
        setclr(deftype(),0);
        const char key=keys(keycode);
        raw_putchar(key);
        // terminal_column-=3;
        // kprintf("    ");
        // terminal_column-=3;
        // kprinth(key);
        setclr(defcol(),0);
    }
}
int kmain(void) {
    vkprintf("s","Hello World!\n");
    while (true){
        while (
            !cmp(just_typed,"hello",hello) &&
            !cmp(just_typed,"hi",hi)
        ) {} // while neither of these have just been typed, do nothing. once they have been, erase them to avoid an infinite loop
        for (int it=0;it<1024;it++) {
            just_typed[it]='\0';
        }
    }
}
