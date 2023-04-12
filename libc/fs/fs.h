#include "../mem/memcpy.h"
typedef struct fs_node {
    char perm[3];
    char contents[1024];
} nodes;
nodes roots={
    "777","Hello from root"
};
nodes info={
    "777","OS: NerdOS \n Version: v0.02 \"ffreestanding\" \n Devs: werdl;thisiscoding1234 \n \
Github: spartanproj/os"
};
typedef struct fs {
    nodes o0;
    nodes o1;
    nodes o2;
    nodes o3;
    nodes o4;
    nodes o5;
    nodes o6;
    nodes o7;
    nodes o8;
    nodes o9;
    nodes info;
} fs_root;
fs_root root={};
int fsinit() {
    root.info=info;
}
int writefs(char towrite[1024], char mode,int file) {
    if (mode=='w') {
        switch (file) {
            case 0: memcpy(root.o0.contents,towrite,1024);return 0;
            case 1: memcpy(root.o1.contents,towrite,1024);return 0;
            case 2: memcpy(root.o2.contents,towrite,1024);return 0;
            case 3: memcpy(root.o3.contents,towrite,1024);return 0;
            case 4: memcpy(root.o4.contents,towrite,1024);return 0;
            case 5: memcpy(root.o5.contents,towrite,1024);return 0;
            case 6: memcpy(root.o6.contents,towrite,1024);return 0;
            case 7: memcpy(root.o7.contents,towrite,1024);return 0;
            case 8: memcpy(root.o8.contents,towrite,1024);return 0;
            case 9: memcpy(root.o9.contents,towrite,1024);return 0;
        }
        return 0;
    }
    else if (mode=='a') {
        char previous[1024];
        switch (file) {
            case 0:
                memcpy(previous,root.o0.contents,1024);
                memcpy(root.o0.contents,strcat(previous,towrite),1024);
                return 0;
            case 1:
                memcpy(previous,root.o1.contents,1024);
                memcpy(root.o1.contents,strcat(previous,towrite),1024);
                return 0;
            case 2:
                memcpy(previous,root.o2.contents,1024);
                memcpy(root.o2.contents,strcat(previous,towrite),1024);
                return 0;
            case 3:
                memcpy(previous,root.o3.contents,1024);
                memcpy(root.o3.contents,strcat(previous,towrite),1024);
                return 0;
            case 4:
                memcpy(previous,root.o4.contents,1024);
                memcpy(root.o4.contents,strcat(previous,towrite),1024);
                return 0;
            case 5:
                memcpy(previous,root.o5.contents,1024);
                memcpy(root.o5.contents,strcat(previous,towrite),1024);
                return 0;
            case 6:
                memcpy(previous,root.o6.contents,1024);
                memcpy(root.o6.contents,strcat(previous,towrite),1024);
                return 0;
            case 7:
                memcpy(previous,root.o7.contents,1024);
                memcpy(root.o7.contents,strcat(previous,towrite),1024);
                return 0;
            case 8:
                memcpy(previous,root.o8.contents,1024);
                memcpy(root.o8.contents,strcat(previous,towrite),1024);
                return 0;
            case 9:
                memcpy(previous,root.o9.contents,1024);
                memcpy(root.o9.contents,strcat(previous,towrite),1024);
                return 0;
        }

    }
}
char * readfs(int file) {
    char * contentsof;
    switch (file) {
        case 0: memcpy(contentsof,root.o0.contents,1024);
        case 1: memcpy(contentsof,root.o1.contents,1024);
        case 2: memcpy(contentsof,root.o2.contents,1024);
        case 3: memcpy(contentsof,root.o3.contents,1024);
        case 4: memcpy(contentsof,root.o4.contents,1024);
        case 5: memcpy(contentsof,root.o5.contents,1024);
        case 6: memcpy(contentsof,root.o6.contents,1024);
        case 7: memcpy(contentsof,root.o7.contents,1024);
        case 8: memcpy(contentsof,root.o8.contents,1024);
        case 9: memcpy(contentsof,root.o9.contents,1024);
    }
    return contentsof;
}
void dump() {
    terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(WHITE, LIGHT_BLUE);
	terminal_buffer = (uint16_t*) 0xB8000;
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
    printf("Contents of journal 0: ");
    printf(root.o0.contents);
    printf("\nContents of journal 1: ");
    printf(root.o1.contents);
    printf("\nContents of journal 2: ");
    printf(root.o2.contents);
    printf("\nContents of journal 3: ");
    printf(root.o3.contents);
    printf("\nContents of journal 4: ");
    printf(root.o4.contents);
    printf("\nContents of journal 5: ");
    printf(root.o5.contents);
    printf("\nContents of journal 6: ");
    printf(root.o6.contents);
    printf("\nContents of journal 7: ");
    printf(root.o7.contents);
    printf("\nContents of journal 8: ");
    printf(root.o8.contents);
    printf("\nContents of journal 9: ");
    printf(root.o9.contents);

    printf("\nContents of EAX: ");
    register int eax asm("eax");
    printh(eax);
    printf("\nContents of EBX: ");
    register int ebx asm("ecx");
    printh(ebx);
    printf("\nContents of ECX: ");
    register int ecx asm("ecx");
    printh(ecx);
    printf("\nContents of EDX: ");
    register int edx asm("edx");
    printh(edx);

    printf("\nContents of stack pointer: ");
    register int esp asm("esp");
    printh(esp);
    printf("\nContents of stack base pointer: ");
    register int ebp asm("ebp");
    printh(ebp);

    printf("\nContents of source: ");
    register int esi asm("esi");
    printh(esi);
    printf("\nContents of destination: ");
    register int edi asm("edi");
    printh(edi);
    setclr(4,9);
    printf("\nTry restarting your computer\n");
    setclr(15,9);
    printf("_   _              _ _____ _____  ______ _____ ___________ _ ");
    printf("\n| \\ | |            | |  _  /  ___| | ___ /  ___|  _  |  _  | |");
    printf("\n|  \\| | ___ _ __ __| | | | \\ `--.  | |_/ \\ `--.| | | | | | | |");
    printf("\n| . ` |/ _ | '__/ _` | | | |`--. \\ | ___ \\`--. | | | | | | | |");
    printf("\n| |\\  |  __| | | (_| \\ \\_/ /\\__/ / | |_/ /\\__/ \\ \\_/ | |/ /|_|");
    printf("\n\\_| \\_/\\___|_|  \\__,_|\\___/\\____/  \\____/\\____/ \\___/|___/ (_)");
}