#! /bin/bash
bold=$(tput bold)
normal=$(tput sgr0)
libgmp=$(/sbin/ldconfig -p | grep libgmp3)
function exists_in_list() {
    LIST=$1
    DELIMITER=$2
    VALUE=$3
    LIST_WHITESPACES=`echo $LIST | tr "$DELIMITER" " "`
    for x in $LIST_WHITESPACES; do
        if [ "$x" = "$VALUE" ]; then
            return 0
        fi
    done
    return 1
}
if  [ -n libgmp ] ; then
    var=true
else
    echo "${bold}Please install libgmp!${normal}"
    exit 1
fi
libmpc=$(/sbin/ldconfig -p | grep libmpc)
if  [ -n libmpc ] ; then
    var=true
else
    echo "${bold}Please install libmpc!${normal}"
    exit 1
fi
libmpfr=$(/sbin/ldconfig -p | grep libmpfr)
if  [ -n libmpfr ] ; then
    var=true
else
    echo "${bold}Please install libmpfr!${normal}"
    exit 1
fi
if which bison; then
    var=true
else 
    echo "${bold}Please install bison.${normal}"
    exit 1
fi
if which flex; then
    var=true
else
    echo "${bold}Please install flex.${normal}"
    exit 1
fi
if which i686-elf-gcc; then
    printf "\n\n"
    read -p "THEME: " input
    echo -e "
    #define NONE 0\n\
#define TERM 1 \n\
#define FIRE 2\n\
#define WATER 3\n\
#define PINK 4\n\

#define OVERWRITE false //change to true: files can be overwritten\n\
#define WARN true //change to false: warnings not given by default\n\
#define FULLDEBUG false //change to true: enable full debugging by default\n\
#define USER \"root\" //change default username: if changed to root, sudo will be autoenabled\n\
#define BOOT_TIME 5 //the number of seconds the boot screen is shown\n\
" > libc/const.h
    list="NONE TERM FIRE WATER PINK"
    
    if exists_in_list "$list"  " " $input; then
    echo "
#define THEME $input" >> libc/const.h
else
    echo "
    #define THEME NONE" >>libc/const.h
fi
    echo -e " \
/* \
DEFCOL OPTIONS \
    BLACK = 0 \
    DARK_BLUE = 1 \
    DARK_GREEN = 2 \
    DARK_CYAN = 3 \
    DEEP_RED = 4 \
    MAGENTA = 5 \
    BROWN = 6 \
    LIGHT_GREY = 7 \
    DARK_GREY = 8 \
    BLUE = 9 \
    GREEN = 10 \
    CYAN = 11 \
    LIGHT_RED = 12 \
    LILAC = 13 \
    YELLOW = 14 \
    WHITE = 15 \
*/ \
//don't touch below this comment! \n\
#if THEME==0 \n\
    #define DEFCOL WHITE  \n\
    #define DEFTYPE LIGHT_GREY \n\
#elif THEME==1 \n\
    #define DEFCOL DARK_GREEN \n\
    #define DEFTYPE GREEN \n\
#elif THEME==2 \n\
    #define DEFCOL DEEP_RED \n\
    #define DEFTYPE YELLOW \n\
#elif THEME==3 \n\
    #define DEFCOL DARK_CYAN \n\
    #define DEFTYPE DARK_BLUE \n\
#elif THEME==4 \n\
    #define DEFCOL MAGENTA \n\
    #define DEFTYPE LILAC \n\
#else \n\
    #define DEFCOL WHITE \n\
    #define DEFTYPE LIGHT_GREY \n\
#endif" >> libc/const.h
    printf "\n\n"
    make elfgcc
    make run
    make clean
else
    $(echo "Consider cross-compiling! Follow the tutorial linked in the README")
    make normalgcc
    make run
    make clean
fi

