/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
#define TTY_H
/* Hardware text mode color constants. */
enum vga_color {
	BLACK = 0,
    DARK_BLUE = 1,
    DARK_GREEN = 2,
    DARK_CYAN = 3,
    DEEP_RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GREY = 7,
    DARK_GREY = 8,
    BLUE = 9,
    GREEN = 10,
    CYAN = 11,
    LIGHT_RED = 12,
    LILAC = 13,
    YELLOW = 14,
    WHITE = 15
};
uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) 
{
	return fg | bg << 4;
}
 
uint16_t vga_entry(unsigned char uc, uint8_t color) 
{
	return (uint16_t) uc | (uint16_t) color << 8;
}
 
size_t strlen(const char * str) 
{
	size_t len = 0;
	while (str[len])
		len++;
	return len;
}
 
static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
 
size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer;
 
void term_init(void) 
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(LIGHT_GREY, BLACK);
	terminal_buffer = (uint16_t*) 0xB8000;
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
}
 
void setclr(enum vga_color colorfg, enum vga_color colorbg) 
{
	terminal_color = vga_entry_color(colorfg,colorbg);
}
