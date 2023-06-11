#!/usr/bin/env bash

# Define colours and font weights
if [[ -t 1 ]]
then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)";
tty_red="$(tty_mkbold 31)";
tty_bold="$(tty_mkbold 39)";
tty_reset="$(tty_escape 0)";

# define functions
ring_bell() {
    # Use the shell's audible bell.
    if [[ -t 1 ]]
    then
        printf "\a"
    fi
}

getc() {
    local save_state
    save_state="$(/bin/stty -g)"
    /bin/stty raw -echo
    IFS='' read -r -n 1 -d '' "$@"
    /bin/stty "${save_state}"
}

# Check for internet connectivity

# See if wget is installed
wget_installed=0
which wget && wget_installed=1
if (( wget_installed == 0 ))
then
    # worse way for detecting internet
    detection_out=$(ping google.com -c 2 | grep time)
    if [[ "$detection_out" == "" ]]
    then
        echo "${tty_red}${tty_bold}You do not have an internet connection. An internet connection is required for this script to run.${tty_reset}"
        echo "${tty_bold}Press any key to exit.${tty_reset}"
        getc c
        exit 1
    fi
elif (( wget_installed == 1 ))
then
    # better way to determine internet
    detection_out=$(wget -q http://detectportal.firefox.com/success.txt --timeout=10 -O - 2> /dev/null)
    if ! [[ "$detection_out" == "success" ]]
    then
        echo "${tty_red}${tty_bold}You do not have an internet connection. An internet connection is required for this script to run.${tty_reset}"
        echo "${tty_bold}Press any key to exit.${tty_reset}"
        getc c
        exit 1
    fi
fi


case $(uname) in
    Linux )
        which dnf && { OS=6; }
        which yum && { OS=2; }
        which zypper && { OS=3; }
        which apt-get && { OS=4; }
        which apk && { OS=5; }
        ;;
    Darwin )
        OS=0
        ;;
  * )
        # Handle AmigaOS, CPM, and modified cable modems.
        echo "${tty_bold}Hey there!${tty_reset}";
        echo "${tty_bold}${tty_red}You are not using a supported operating system or do not have a compatible package manager installed.${tty_reset}";
        printf "You need to use an OS with one of these package managers (or install them):\n- yum\n- zypper\n- apt\n- apk\n- dnf\n- pacman\n";
        echo "To try ${tty_bold}brew${tty_reset}, press ${tty_bold}RETURN/ENTER${tty_reset} or any other key to abort.";
        c="1 + 1 = 11";
        getc c;
        if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]
        then
            exit 1
        fi
        OS=1
        ;;
esac

if (( OS == 0 ))
then
    echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}You are on macOS. Full support is not guaranteed, though it has been tested.${tty_reset}";
    BREW=0;
    which brew > /dev/null&& BREW=1; # No output
    if (( BREW == 0 ))
    then
        echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Brew is not installed. If you continue, Brew will be automatically installed. (It may require sudo priviliges)${tty_reset}";
    fi
fi

echo "This installer will install the ${tty_bold}dependencies${tty_reset} for NerdOS and build a QEMU binary which it will proceed to run.";
echo
echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold} This script will install:"
echo "- The dependencies to build NerdOS: qemu nasm bison flex libmpc mpfr texinfo gmp"
echo "- Will create 2 directories: build-bintools and build-gcc."
echo "- Will clone the NerdOS git repository into os"
if [ $OS == 0 ] || [ $OS == 1 ]
then
    echo "- Download the brew install script to temp"
    echo "- Build and install MacPorts"
fi
echo
echo "To continue, press ${tty_bold}RETURN/ENTER${tty_reset}. Press any other key to abort.";

c="i want to get cancelled!!!!!";
getc c;
# we test for \r and \n because some stuff does \r instead
if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]
then
    exit 1
fi

if (( OS == 0 ))
then
    MACPORTS=0
    which port >> /dev/null && MACPORTS=1
    if (( MACPORTS==0 ))
    then
        mkdir temp;
        cd temp || return;
        # Install MacPorts
        curl -fsSL https://github.com/macports/macports-base/releases/download/v2.8.1/MacPorts-2.8.1.tar.gz;
        tar xzvf MacPorts-2.8.1.tar.gz
        cd MacPorts-2.8.1 || return
        ./configure && make && sudo make install
        cd ..;
        rm -rf temp;
        sudo port -v selfupdate
        
    fi
    if (( BREW == 0 ))
    then
        # Create a temporary folder.
        mkdir temp;
        cd temp || return;
        
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh;
        ./install.sh;

        
        cd ..;
        rm -rf temp;
    fi
fi

if (( OS == 1 ))
then
    mkdir temp;
    cd temp || return;
    
    # Install Homebrew
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh;
    ./install.sh;
    

    

    cd ..;
    cd ..;
    rm -rf temp;
fi

# Install packages

echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Installing packages... (password may be required)"
if (( OS == 4 ))
then
    sudo apt update
    sudo apt install qemu nasm qemu-system-x86 build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo 

elif (( OS == 0 ))
then
    brew install python3 gcc qemu nasm bison flex gmp libmpc mpfr texinfo binutils
    sudo port install gmp mpfr libmpc
elif (( OS == 1 ))
then
    brew install qemu nasm bison flex gmp libmpc mpfr texinfo binutils
elif (( OS == 6 ))
then
    sudo dnf install qemu nasm bison flex mpc mpfr texinfo gmp gcc-c++
elif (( OS == 2 ))
then
    sudo yum install qemu nasm bison flex libmpc mpfr texinfo gmp
elif (( OS == 3 ))
then
    sudo zypper install qemu nasm bison flex libmpc mpfr texinfo gmp
elif (( OS == 5 ))
then
    apk update
    apk upgrade
    apk add build-base qemu nasm bison flex make mpc mpfr texinfo gmp
else
    brew install qemu nasm bison flex gmp libmpc mpfr texinfo binutils || return
fi


# Target
export TARGET=i686-elf
export PREFIX="$HOME/opt/cross"
echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Fetching binutils"
cd "$HOME" || return

export PATH="$PREFIX/bin:$PATH"
curl https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz -o bin.tar.xz
tar xf bin.tar.xz

echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Configuring binutils"
mkdir build-binutils
cd build-binutils || return
export CC=gcc
../binutils-2.39/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j 8
make install -j8

echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Fetching gcc"
cd "$HOME" || return
curl https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-12.2.0/gcc-12.2.0.tar.xz -o gcc.tar.xz
tar xf gcc.tar.xz
which -- $TARGET-as || echo $TARGET-as is not in the PATH
echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Configuring gcc"
mkdir build-gcc
cd build-gcc || return
../gcc-12.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc -j 8
make all-target-libgcc -j 8
make install-gcc -j 8
make install-target-libgcc -j 8

export PATH="$HOME/opt/cross/bin:$PATH"
# echo "export PATH=\"$HOME/opt/cross/bin:$PATH\"" >> ~/.bashrc

echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Cloning git repository"
git clone https://github.com/spartanproj/os
cd os || return
echo "${tty_bold}${tty_blue}==>${tty_reset} ${tty_bold}Running make & make run"
make && make run
echo
echo "${tty_bold}To run NerdOS, use make run.${tty_reset}"
echo "${tty_bold}To rebuild gcc and binutils run make.${tty_reset}"
echo
echo "To add the $TARGET binaries into your path, place this into your .zshrc or .bashrc:"
echo "${tty_bold}export PATH="$HOME/opt/cross/bin:$PATH"${tty_reset}"
