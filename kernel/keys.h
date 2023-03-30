
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
        case 0x0c:
            return("-");
        case 0x0d:
            return ("=");
        case 0x0f:
            return "Tab";
        case 0x10:
            return "q";
        case 0x11:
            return "w";
        case 0x12:
            return "e";
        case 0x13:
            return "r";
        case 0x14:
            return "t";
        case 0x15:
            return "y";
        case 0x16:
            return "u";
        case 0x17:
            return "i";
        case 0x18:
            return "o";
        case 0x19:
            return "p";
        default:
            panic("Character wasn't found in switch","Character error.");
            return "Error";
    }


}