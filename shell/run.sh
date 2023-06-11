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
    echo -e "" > libc/const.h
    printf "\n\n"
    make elfgcc
    make run
    make clean
else
    $(echo "Consider cross-compiling! Follow the tutorial linked in the README. This may work, but down the line you might be in trouble!")
    make normalgcc
    make run
    make clean
fi

