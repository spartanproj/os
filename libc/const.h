
    #define NONE 0
#define TERM 1 
#define FIRE 2
#define WATER 3
#define PINK 4

#define OVERWRITE false //change to true: files can be overwritten
#define WARN true //change to false: warnings not given by default
#define FULLDEBUG false //change to true: enable full debugging by default
#define USER "root" //change default username: if changed to root, sudo will be autoenabled
#define BOOT_TIME 5 //the number of seconds the boot screen is shown


#define THEME FIRE
 /* DEFCOL OPTIONS     BLACK = 0     DARK_BLUE = 1     DARK_GREEN = 2     DARK_CYAN = 3     DEEP_RED = 4     MAGENTA = 5     BROWN = 6     LIGHT_GREY = 7     DARK_GREY = 8     BLUE = 9     GREEN = 10     CYAN = 11     LIGHT_RED = 12     LILAC = 13     YELLOW = 14     WHITE = 15 */ //don't touch below this comment! 
#if THEME==0 
    #define DEFCOL WHITE  
    #define DEFTYPE LIGHT_GREY 
#elif THEME==1 
    #define DEFCOL DARK_GREEN 
    #define DEFTYPE GREEN 
#elif THEME==2 
    #define DEFCOL DEEP_RED 
    #define DEFTYPE YELLOW 
#elif THEME==3 
    #define DEFCOL DARK_CYAN 
    #define DEFTYPE DARK_BLUE 
#elif THEME==4 
    #define DEFCOL MAGENTA 
    #define DEFTYPE LILAC 
#else 
    #define DEFCOL WHITE 
    #define DEFTYPE LIGHT_GREY 
#endif
