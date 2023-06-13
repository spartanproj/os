

void kprintf(const char * msg) {
    setclr(11,0);
    printf("kernel: ");
    setclr(15,0);
    printf(msg);
}

void kprintd(const char * msg, bool second) {
    kprintf(msg);
    if (second==true) {
        setclr(2,0);
        printf("SUCCESS");
    } else {
        setclr(4,0);
        printf("FAILURE");
    }
    setclr(15,0);
}
#define OVERWRITE false //change to true: files can be overwritten\n
#define WARN true //change to false: warnings not given by default\n
#define FULLDEBUG false //change to true: enable full debugging by default\n#define BOOT_TIME 5 //the number of seconds the boot screen is shown\n

