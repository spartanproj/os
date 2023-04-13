void printtime(bool seconds) {
    int byte;
    write_port(0x70,(0 << 7)|0x04);
	byte=read_port(0x71);
	printhx(byte);
	printf(":");


    write_port(0x70,(0 << 7)|0x02);
	byte=read_port(0x71);
	printhx(byte);
    if (seconds) {

    printf(":");
    write_port(0x70,(0 << 7)|0x00);
	byte=read_port(0x71);
	printhx(byte);
    }
}
void printdate() {
    printtime(false);
    printf(" - ");
    int byte;
    write_port(0x70,(0 << 7)|0x06);
	byte=read_port(0x71);
	switch (byte-0x01) {
        case 0x01:printf("Monday");goto end;
        case 0x02:printf("Tuesday");goto end;
        case 0x03:printf("Wednesday");goto end;
        case 0x04:printf("Thursday");goto end;
        case 0x05:printf("Friday");goto end;
        case 0x06:printf("Saturday");goto end;
        case 0x00:printf("Sunday");goto end;
    }
    end:
	printf(" ");

    write_port(0x70,(0 << 7)|0x07);
	byte=read_port(0x71);
	printhx(byte);
	printf(" ");

    write_port(0x70,(0 << 7)|0x08);
	byte=read_port(0x71);
	switch (byte) {
        case 1:printf("January");goto end2;
        case 2:printf("February");goto end2;
        case 3:printf("March");goto end2;
        case 4:printf("April");goto end2;
        case 5:printf("May");goto end2;
        case 6:printf("June");goto end2;
        case 7:printf("July");goto end2;
        case 8:printf("August");goto end2;
        case 9:printf("September");goto end2;
        case 10:printf("October");goto end2;
        case 11:printf("November");goto end2;
        case 12:printf("December");goto end2;
    }
    end2:
    printf(" ");
    write_port(0x70,(0 << 7)|0x32);
	byte=read_port(0x71);
	printhx(byte);
    write_port(0x70,(0 << 7)|0x09);
	byte=read_port(0x71);
	printhx(byte);
    printf("\n");
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