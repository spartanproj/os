cd $HOME
sudo apt install qemu nasm
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo 
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
curl https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz -o bin.tar.xz
tar xf bin.tar.xz


mkdir build-binutils
cd build-binutils
export CC=gcc
../binutils-2.39/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j 8
make install -j8

cd $HOME
curl https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-12.2.0/gcc-12.2.0.tar.xz -o gcc.tar.xz
tar xf gcc.tar.xz
which -- $TARGET-as || echo $TARGET-as is not in the PATH
mkdir build-gcc
cd build-gcc
../gcc-12.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc -j 8
make all-target-libgcc -j 8
make install-gcc -j 8
make install-target-libgcc -j 8

export PATH="$HOME/opt/cross/bin:$PATH"
echo "export PATH=\"$HOME/opt/cross/bin:$PATH\"" >> ~/.bashrc

git clone https://github.com/spartanproj/os
cd os
make && make run
echo "To run again type this: \
make && make run"
