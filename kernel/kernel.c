#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <kernel/idt.h>
#include <stdio.h>
#include <util.h>
#include <mem/alloc.h> // kmalloc
#include <mem/memcmp.h> // memcmp
#include <mem/memcpy.h>
#include <io/clr.h>
#include "keyboard.h"
#include <time.h>
#include <io/util.h>

int counter=0; // counts how many keys have been pressed
char typed[1024]; // holds current line of keyboard input
char just_typed[1024]; // holds input that was typed before enter was pressed
void dellast(void) {
    // deletes last character from working keyboard memory
        typed[counter]='\0';
        counter--;
}
void keyboard_handler_main(void)
{
    // handles keyboard input, called by boot.asm
        unsigned char status;
        char keycode;
        write_port(0x20, 0x20);

        status = read_port(KEYBOARD_STATUS_PORT);
        if (status & 0x01) {
                keycode = read_port(KEYBOARD_DATA_PORT);
                if(keycode<0)
                        return;
                else if(keycode == ENTER_KEY_CODE) {
                        kprintf("\n");                  // checktype();
            memcpy(just_typed,typed,1024);
                        for (int it=0;it<1024;it++) {
                                typed[it]='\0';
                        }
                        counter=0;
            terminal_column--;
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
                putchar(key);
        // terminal_column-=3;
        // kprintf("    ");
        // terminal_column-=3;
        // kprinth(key);
                setclr(defcol(),0);
        }
}
void hello() {
    kprintf("And to you!\n");
}
void hi() {
    kprintf("mom!\n");
}
int kmain() {
    term_init();
    idt_init();
    kb_init();
    kprintf("Hello World!\nhi\n");
    kprintn(3);

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
