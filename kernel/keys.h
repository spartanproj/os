
#include <kernel/abort.h>
const char * keys(int value) {

    switch (value) {
        case 0x01:
            return "Escape";
            break;
        case 0x02:
            return "1";
        case 0x03:
            return "2";
        case 0x04:
            return "3";
        case 0x05:
            return "4";
        case 0x06:
            return "5";
        case 0x07: 
            return "6";
        case 0x08:
            return "7";
        case 0x09:
            return "8";
        case 0x0A:
            return "9";
        case 0x0B:
            return "0";
        default:
            panic("Character wasn't found in switch","Character error.");
            return "Error";
    }


}