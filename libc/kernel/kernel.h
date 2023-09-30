/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/



void kprintd(const char * msg, bool second) {
    kprintf(msg);
    if (second==true) {
        setclr(2,0);
        kprintf("SUCCESS");
    } else {
        setclr(4,0);
        kprintf("FAILURE");
    }
    setclr(15,0);
}
#define OVERWRITE false //change to true: files can be overwritten\n
#define WARN true //change to false: warnings not given by default\n
#define FULLDEBUG false //change to true: enable full debugging by default\n#define BOOT_TIME 5 //the number of seconds the boot screen is shown\n

