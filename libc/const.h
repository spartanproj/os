/*
    name: const.h
    purpose: user-defined constants to help with NerdOS usage
*/
enum theme {
	NONE = 0
};
#define OVERWRITE false //change to true: files can be overwritten
#define WARN true //change to false: warnings not given by default
#define FULLDEBUG false //change to true: enable full debugging by default
#define USER "root" //change default username: if changed to root, sudo will be autoenabled
#define BOOT_TIME 5 //the number of seconds the boot screen is shown
#define DEFCOL GREEN //default colour
#define DEFTYPE DARK_GREEN //colour of text you type

#define THEME NONE

/*
DEFCOL OPTIONS
    BLACK = 0
    DARK_BLUE = 1
    DARK_GREEN = 2
    DARK_CYAN = 3
    DEEP_RED = 4
    MAGENTA = 5
    BROWN = 6
    LIGHT_GREY = 7
    DARK_GREY = 8
    BLUE = 9
    GREEN = 10
    CYAN = 11
    LIGHT_RED = 12
    LILAC = 13
    YELLOW = 14
    WHITE = 15
*/
//don't touch below this comment!
#if THEME==0
    #define DEFCOL WHITE
    #define DEFTYPE LIGHT_GREY
#endif