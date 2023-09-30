/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/

#include <kernel/abort.h>
char keys(int value) {

    switch (value) {
        // case 0x01:
        //     return "Escape";
        //     break;
                case 0x02:
            return '1';
        case 0x03:
            return '2';
        case 0x04:
            return '3';
        case 0x05:
            return '4';
        case 0x06:
            return '5';
        case 0x07: 
            return '6';
        case 0x08:
            return '7';
        case 0x09:
            return '8';
        case 0x0A:
            return '9';
        case 0x0B:
            return '0';
        case 0x0c:
            return('-');
        case 0x0d:
            return ('=');
        case 0x0e:
            return '`';
        // case 0x0f:
        //     return "Tab";
	    case 0x10:
            return 'q';
        case 0x11:
            return 'w';
        case 0x12:
            return 'e';
        case 0x13:
            return 'r';
        case 0x14:
            return 't';
        case 0x15:
            return 'y';
        case 0x16:
            return 'u';
        case 0x17:
            return 'i';
        case 0x18:
            return 'o';
        case 0x19:
            return 'p';
        case 0x1a:
            return '{';
        case 0x1b:
            return '}';
        case 0x1c:
            return '\n';
        // case 0x1d:
        //     return "L-CTRL";
	    case 0x1e:
            return 'a';
        case 0x1f:
            return 's';
        case 0x20:
            return 'd';
        case 0x21:
            return 'f';
        case 0x22:
            return 'g';
        case 0x23:
            return 'h';
        case 0x24:
            return 'j';
        case 0x25:
            return 'k';
        case 0x26:
            return 'l';
        case 0x27:
            return ';';
        case 0x28:
            return '\'';
        case 0x29:
            return '#';
        // case 0x2a:
        //     return "L-SHIFT";
	    case 0x2b:
            return '\\';
        case 0x2c:
            return 'z';
        case 0x2d:
            return 'x';
        case 0x2e:
            return 'c';
        case 0x2f:
            return 'v';
        case 0x30:
            return 'b';
        case 0x31:
            return 'n';
        case 0x32:
            return 'm';
        case 0x33:
            return ',';
        case 0x34:
            return '.';
        case 0x35:
            return '/';
        // case 0x36:
        //     return "R-SHIFT";
        case 0x37:
            return '-';
        // case 0x38:
        //     return "L-ALT";
        case 0x39:
            return ' ';
        // case 0x3a:
        //     return "CAPS";
        // case 0x3b:
        //     return "F1";
        // case 0x3c:
        //     return "F2";
        // case 0x3d:
        //     return "F3";
        // case 0x3e:
        //     return "F4";
        // case 0x3f:
        //     return "F5";
        // case 0x40:
        //     return "F6";
        // case 0x41:
        //     return "F7";
        // case 0x42:
        //     return "F8";
        // case 0x43:
        //     return "F9";
        // case 0x44:
        //     return "F10";
        // case 0x45:
        //     return "NUM";
        // case 0x46:
        //     return "SCROLL";
        // //some more here
        // case 0x48:
        //     return "UP";
        // //more needed
        // case 0x4b:
        //     return "LEFT";
        // //more
        // case 0x4d:
        //     return "RIGHT";
        // //more
        // case 0x50:
        //     return "DOWN";
        default:
            return '?';
    }


}