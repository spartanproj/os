/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdarg.h>
#include <io/tty.h>
#if !defined(__i386__)
#error "Enjoy your debugging :)"
#endif
void kprintf(const char * data); 
bool just_nl=false;

void write_to(char c, uint8_t color, size_t x, size_t y) 
{
	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}
void raw_putchar(char c) {
	write_to(c, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT)
			terminal_row = 0;
	}
}
void putchar(char c) 
{
    if (just_nl) {
		terminal_column++;
		just_nl=false;
	}
	write_to(c, terminal_color, terminal_column, terminal_row);
	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT)
			terminal_row = 0;
	}
}
 
void write(const char * data, size_t size, bool magic) 
{
	int n;
	for (size_t i = 0; i < size; i++) {
        while (data[i]=='\n') {
            terminal_row = terminal_row + 1;
            terminal_column = -1;
			just_nl=true;
            i++;
        }
        
		putchar(data[i]);
		n=i;
    }
}
void clear(void) {
	term_init();
	kprintf(" ");
}
void kprintf(const char * data) 
{
	if (terminal_row>=VGA_HEIGHT) {
		clear();
		clear_screen();
		// for(int i = 0; i < VGA_HEIGHT; i++){
        
		// for (int m = 0; m < VGA_WIDTH; m++){
        //     terminal_buffer[i * VGA_WIDTH + m] = terminal_buffer[(i + 1) * VGA_WIDTH + m];
        // }
    // }
	}
	write(data, strlen(data),0);
}
void kprintn(int num);
void vkprintf(const char * fmt, ...) {
	va_list arg;
	int done;
	va_start(arg,fmt);
	while(*fmt!='\0') {
     	// string
		if(*fmt=='s') {
			char* s=va_arg(arg, char *);
			kprintf(s);
		}
		// character
		else if(*fmt=='c') {
			char c=(char)va_arg(arg, int);
			putchar(c);
			break;
		}
		// integer || boolean
		else if(*fmt=='d' || *fmt=='b') {
			int d=va_arg(arg, int );
			kprintn(d);
		}          
     	*fmt++;
   }   
}
void nprintf(const char * data) {
	if (terminal_row>=VGA_HEIGHT) {
		for(int i = 0; i < VGA_HEIGHT; i++){
        for (int m = 0; m < VGA_WIDTH; m++){
            terminal_buffer[i * VGA_WIDTH + m] = terminal_buffer[(i + 1) * VGA_WIDTH + m];
        }
    }
	}
	write(data, strlen(data),1);
}
