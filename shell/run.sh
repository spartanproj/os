#!/usr/bin/env bash
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

if which i686-elf-gcc; then
    echo -e "" > libc/const.h
    printf "\n\n"
    make elfgcc
    make run
    make clean
else
    if (( $(uname) == "Darwin" ))
    then
        echo "Compiling for macOS!"
        make macos
        make run
        make clean
    else
        echo "Consider cross-compiling! Follow the tutorial linked in the README"
        make normalgcc
        make run
        make clean
    fi
fi

