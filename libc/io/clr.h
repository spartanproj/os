/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
bool checkclr(char * color) {
	return !memcmp(search("color.conf"),color,strlen(color));
}
#define check(x) checkclr(x)
int getcolors(bool type) {
	static int defcol;
	static int deftype;
	if (check("TERM")) {
		defcol=2;
		deftype=10;
	} else if (check("PINK")) {
		defcol=5;
		deftype=13;
	} else if (check("BORE")) {
		defcol=8;
		deftype=7;
	} else if (check("ANGER")) {
		defcol=4;
		deftype=12;
	} else if (check("BLUE")) {
		defcol=3;
		deftype=11;
	} else if (check("FIRE")) {
		defcol=4;
		deftype=14;
	} else if (check("RETRO")) {
		defcol=2;
		deftype=14;
	} else if (check("LIGHT")) {
		panic("Light mode activated, defensive kernel panic initiated","Wrong mode",1);
	}
	
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