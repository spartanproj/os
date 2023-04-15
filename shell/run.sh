libgmp=$(/sbin/ldconfig -p | grep libgmp3)
if  [ -n libgmp ] ; then
    var=true
else
    echo "\rPlease install libgmp!"
    exit 1
fi
libmpc=$(/sbin/ldconfig -p | grep libmpc)
if  [ -n libmpc ] ; then
    var=true
else
    echo "\rPlease install libmpc!"
    exit 1
fi
libmpfr=$(/sbin/ldconfig -p | grep libmpfr)
if  [ -n libmpfr ] ; then
    var=true
else
    echo "\rPlease install libmpfr!"
    exit 1
fi
if which bison; then
    var=true
else 
    echo "Please install bison."
    exit 1
fi
if which flex; then
    var=true
else
    echo "Please install flex."
    exit 1
fi
if which i686-elf-gcc; then
    make elfgcc
    make run
    make clean
else
    $(shell echo "Consider cross-compiling! Follow the tutorial linked in the README")
    make normalgcc
    make run
    make clean
fi

