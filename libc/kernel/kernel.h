

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