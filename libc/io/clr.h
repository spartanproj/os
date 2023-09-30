/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
int getcolors(bool type) {
	static int defcol;
	static int deftype;
	defcol=8;
	deftype=7;
	if (type) { // default type
		return deftype;
	} else return defcol;
}
int defcol() {
	return getcolors(0);
}
int deftype() {
	return getcolors(1);
}