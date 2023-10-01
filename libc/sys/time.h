/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
void printtime(bool seconds) {
    int byte;
    write_port(0x70,(0 << 7)|0x04);
	byte=read_port(0x71);
    if (byte<10) {
        kprintf("0");
    }
	kprinthx(byte);
	kprintf(":");


    write_port(0x70,(0 << 7)|0x02);
	byte=read_port(0x71);
    if (byte<10) {
        kprintf("0");
    }
	kprinthx(byte);
    if (seconds) {

    kprintf(":");
    write_port(0x70,(0 << 7)|0x00);
	byte=read_port(0x71);
    if (byte<10) {
        kprintf("0");
    }
	kprinthx(byte);
    }
}
void printdate() {
    printtime(true);
    kprintf(" - ");
    int byte;
    write_port(0x70,(0 << 7)|0x06);
	byte=read_port(0x71);
	switch (byte-0x01) {
        case 0x01:kprintf("Monday");goto end;
        case 0x02:kprintf("Tuesday");goto end;
        case 0x03:kprintf("Wednesday");goto end;
        case 0x04:kprintf("Thursday");goto end;
        case 0x05:kprintf("Friday");goto end;
        case 0x06:kprintf("Saturday");goto end;
        case 0x00:kprintf("Sunday");goto end;
    }
    end:
	kprintf(" ");

    write_port(0x70,(0 << 7)|0x07);
	byte=read_port(0x71);
	kprinthx(byte);
	kprintf(" ");

    write_port(0x70,(0 << 7)|0x08);
	byte=read_port(0x71);
	switch (byte) {
        case 1:kprintf("January");goto end2;
        case 2:kprintf("February");goto end2;
        case 3:kprintf("March");goto end2;
        case 4:kprintf("April");goto end2;
        case 5:kprintf("May");goto end2;
        case 6:kprintf("June");goto end2;
        case 7:kprintf("July");goto end2;
        case 8:kprintf("August");goto end2;
        case 9:kprintf("September");goto end2;
        case 10:kprintf("October");goto end2;
        case 11:kprintf("November");goto end2;
        case 12:kprintf("December");goto end2;
    }
    end2:
    kprintf(" ");
    write_port(0x70,(0 << 7)|0x32);
	byte=read_port(0x71);
	kprinthx(byte);
    write_port(0x70,(0 << 7)|0x09);
	byte=read_port(0x71);
	kprinthx(byte);
    kprintf("\n");
	mse_nl();
}
void sleep(int seconds) {
    write_port(0x70,(0 << 7)|0x00);
	int init=read_port(0x71);
    int current;
    while(true) {
        write_port(0x70,(0 << 7)|0x00);
	    current=read_port(0x71);
        if ((current-init)>=seconds) break;
    }
}
void time() {
    int byte,total;
    write_port(0x70,(0 << 7)|0x00);
	byte=read_port(0x71);
    char bufa[15];
    itoa(byte,bufa,16);
    byte=atoi(bufa);
    total+=byte;

    write_port(0x70,(0 << 7)|0x02);
	byte=read_port(0x71);
    char bufb[100];
    itoa(byte,bufb,16);
    byte=atoi(bufb);
    total+=byte*60;

    write_port(0x70,(0 << 7)|0x04);
	byte=read_port(0x71);
    char bufc[10000];
    itoa(byte,bufc,16);
    byte=atoi(bufc);
    total+=byte*3600;



    kprintn(total);
}