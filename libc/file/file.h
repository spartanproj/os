/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
#include "alloc.h"
#include "../mem/memcmp.h"
file newfile(char name[8], char contents[8]) {
    file newfile;
    memcpy(newfile.contents,contents,1024);
    memcpy(newfile.name,contents,1024);
    newfile.free=false;
    return newfile;
}
int writef(file * writeto, char contents[1024], char mode) {
    if (mode=='w') {
        memcpy(writeto->contents,contents,1024);
    }

}
int wipe(file towipe) {
    memcpy(towipe.name,"\0",1024);
    memcpy(towipe.contents,"\0",1024);
    towipe.free=true;
    return 0;
}
file create() {
    file created;
    memcpy(created.name,"\0",1024);
    memcpy(created.contents,"\0",1024);
    created.free=true;
    return created;
}

int writ(char contents[1024],char name[8]) {
    if (f0.free!=false){memcpy(f0.contents,contents,1024); memcpy(f0.name,name,8); f0.free=false;return 0;}
    else if (f1.free!=false){memcpy(f1.contents,contents,1024); memcpy(f1.name,name,8); f1.free=false;return 1;}
    else if (f2.free!=false){memcpy(f2.contents,contents,1024); memcpy(f2.name,name,8); f2.free=false;return 2;}
    else if (f3.free!=false){memcpy(f3.contents,contents,1024); memcpy(f3.name,name,8); f3.free=false;return 3;}
    else if (f4.free!=false){memcpy(f4.contents,contents,1024); memcpy(f4.name,name,8); f4.free=false;return 4;}
    else if (f5.free!=false){memcpy(f5.contents,contents,1024); memcpy(f5.name,name,8); f5.free=false;return 5;}
    else if (f6.free!=false){memcpy(f6.contents,contents,1024); memcpy(f6.name,name,8); f6.free=false;return 6;}
    else if (f7.free!=false){memcpy(f7.contents,contents,1024); memcpy(f7.name,name,8); f7.free=false;return 7;}
    else if (f8.free!=false){memcpy(f8.contents,contents,1024); memcpy(f8.name,name,8); f8.free=false;return 8;}
    else if (f9.free!=false){memcpy(f9.contents,contents,1024); memcpy(f9.name,name,8); f9.free=false;return 9;}
    else if (f10.free!=false){memcpy(f10.contents,contents,1024); memcpy(f10.name,name,8); f10.free=false;return 10;}
    else if (f11.free!=false){memcpy(f11.contents,contents,1024); memcpy(f11.name,name,8); f11.free=false;return 11;}
    else if (f12.free!=false){memcpy(f12.contents,contents,1024); memcpy(f12.name,name,8); f12.free=false;return 12;}
    else if (f13.free!=false){memcpy(f13.contents,contents,1024); memcpy(f13.name,name,8); f13.free=false;return 13;}
    else if (f14.free!=false){memcpy(f14.contents,contents,1024); memcpy(f14.name,name,8); f14.free=false;return 14;}
    else if (f15.free!=false){memcpy(f15.contents,contents,1024); memcpy(f15.name,name,8); f15.free=false;return 15;}
    else if (f16.free!=false){memcpy(f16.contents,contents,1024); memcpy(f16.name,name,8); f16.free=false;return 16;}
    else if (f17.free!=false){memcpy(f17.contents,contents,1024); memcpy(f17.name,name,8); f17.free=false;return 17;}
    else if (f18.free!=false){memcpy(f18.contents,contents,1024); memcpy(f18.name,name,8); f18.free=false;return 18;}
    else if (f19.free!=false){memcpy(f19.contents,contents,1024); memcpy(f19.name,name,8); f19.free=false;return 19;}
    else if (f20.free!=false){memcpy(f20.contents,contents,1024); memcpy(f20.name,name,8); f20.free=false;return 20;}
    else if (f21.free!=false){memcpy(f21.contents,contents,1024); memcpy(f21.name,name,8); f21.free=false;return 21;}
    else if (f22.free!=false){memcpy(f22.contents,contents,1024); memcpy(f22.name,name,8); f22.free=false;return 22;}
    else if (f23.free!=false){memcpy(f23.contents,contents,1024); memcpy(f23.name,name,8); f23.free=false;return 23;}
    else if (f24.free!=false){memcpy(f24.contents,contents,1024); memcpy(f24.name,name,8); f24.free=false;return 24;}
    else if (f25.free!=false){memcpy(f25.contents,contents,1024); memcpy(f25.name,name,8); f25.free=false;return 25;}
    else if (f26.free!=false){memcpy(f26.contents,contents,1024); memcpy(f26.name,name,8); f26.free=false;return 26;}
    else if (f27.free!=false){memcpy(f27.contents,contents,1024); memcpy(f27.name,name,8); f27.free=false;return 27;}
    else if (f28.free!=false){memcpy(f28.contents,contents,1024); memcpy(f28.name,name,8); f28.free=false;return 28;}
    else if (f29.free!=false){memcpy(f29.contents,contents,1024); memcpy(f29.name,name,8); f29.free=false;return 29;}
    else if (f30.free!=false){memcpy(f30.contents,contents,1024); memcpy(f30.name,name,8); f30.free=false;return 30;}
    else if (f31.free!=false){memcpy(f31.contents,contents,1024); memcpy(f31.name,name,8); f31.free=false;return 31;}
    else if (f32.free!=false){memcpy(f32.contents,contents,1024); memcpy(f32.name,name,8); f32.free=false;return 32;}
    else if (f33.free!=false){memcpy(f33.contents,contents,1024); memcpy(f33.name,name,8); f33.free=false;return 33;}
    else if (f34.free!=false){memcpy(f34.contents,contents,1024); memcpy(f34.name,name,8); f34.free=false;return 34;}
    else if (f35.free!=false){memcpy(f35.contents,contents,1024); memcpy(f35.name,name,8); f35.free=false;return 35;}
    else if (f36.free!=false){memcpy(f36.contents,contents,1024); memcpy(f36.name,name,8); f36.free=false;return 36;}
    else if (f37.free!=false){memcpy(f37.contents,contents,1024); memcpy(f37.name,name,8); f37.free=false;return 37;}
    else if (f38.free!=false){memcpy(f38.contents,contents,1024); memcpy(f38.name,name,8); f38.free=false;return 38;}
    else if (f39.free!=false){memcpy(f39.contents,contents,1024); memcpy(f39.name,name,8); f39.free=false;return 39;}
    else if (f40.free!=false){memcpy(f40.contents,contents,1024); memcpy(f40.name,name,8); f40.free=false;return 40;}
    else if (f41.free!=false){memcpy(f41.contents,contents,1024); memcpy(f41.name,name,8); f41.free=false;return 41;}
    else if (f42.free!=false){memcpy(f42.contents,contents,1024); memcpy(f42.name,name,8); f42.free=false;return 42;}
    else if (f43.free!=false){memcpy(f43.contents,contents,1024); memcpy(f43.name,name,8); f43.free=false;return 43;}
    else if (f44.free!=false){memcpy(f44.contents,contents,1024); memcpy(f44.name,name,8); f44.free=false;return 44;}
    else if (f45.free!=false){memcpy(f45.contents,contents,1024); memcpy(f45.name,name,8); f45.free=false;return 45;}
    else if (f46.free!=false){memcpy(f46.contents,contents,1024); memcpy(f46.name,name,8); f46.free=false;return 46;}
    else if (f47.free!=false){memcpy(f47.contents,contents,1024); memcpy(f47.name,name,8); f47.free=false;return 47;}
    else if (f48.free!=false){memcpy(f48.contents,contents,1024); memcpy(f48.name,name,8); f48.free=false;return 48;}
    else if (f49.free!=false){memcpy(f49.contents,contents,1024); memcpy(f49.name,name,8); f49.free=false;return 49;}
    else if (f50.free!=false){memcpy(f50.contents,contents,1024); memcpy(f50.name,name,8); f50.free=false;return 50;}
    else if (f51.free!=false){memcpy(f51.contents,contents,1024); memcpy(f51.name,name,8); f51.free=false;return 51;}
    else if (f52.free!=false){memcpy(f52.contents,contents,1024); memcpy(f52.name,name,8); f52.free=false;return 52;}
    else if (f53.free!=false){memcpy(f53.contents,contents,1024); memcpy(f53.name,name,8); f53.free=false;return 53;}
    else if (f54.free!=false){memcpy(f54.contents,contents,1024); memcpy(f54.name,name,8); f54.free=false;return 54;}
    else if (f55.free!=false){memcpy(f55.contents,contents,1024); memcpy(f55.name,name,8); f55.free=false;return 55;}
    else if (f56.free!=false){memcpy(f56.contents,contents,1024); memcpy(f56.name,name,8); f56.free=false;return 56;}
    else if (f57.free!=false){memcpy(f57.contents,contents,1024); memcpy(f57.name,name,8); f57.free=false;return 57;}
    else if (f58.free!=false){memcpy(f58.contents,contents,1024); memcpy(f58.name,name,8); f58.free=false;return 58;}
    else if (f59.free!=false){memcpy(f59.contents,contents,1024); memcpy(f59.name,name,8); f59.free=false;return 59;}
    else if (f60.free!=false){memcpy(f60.contents,contents,1024); memcpy(f60.name,name,8); f60.free=false;return 60;}
    else if (f61.free!=false){memcpy(f61.contents,contents,1024); memcpy(f61.name,name,8); f61.free=false;return 61;}
    else if (f62.free!=false){memcpy(f62.contents,contents,1024); memcpy(f62.name,name,8); f62.free=false;return 62;}
    else if (f63.free!=false){memcpy(f63.contents,contents,1024); memcpy(f63.name,name,8); f63.free=false;return 63;}

}
char * read(char name[8]) {
    if (memcmp(f0.name,name,strlen(name))==0) return f0.contents;
    else if (memcmp(f1.name,name,strlen(name))==0) {return f1.contents;}
    else if (memcmp(f2.name,name,strlen(name))==0) {return f2.contents;}
    else if (memcmp(f3.name,name,strlen(name))==0) {return f3.contents;}
    else if (memcmp(f4.name,name,strlen(name))==0) {return f4.contents;}
    else if (memcmp(f5.name,name,strlen(name))==0) {return f5.contents;}
    else if (memcmp(f6.name,name,strlen(name))==0) {return f6.contents;}
    else if (memcmp(f7.name,name,strlen(name))==0) {return f7.contents;}
    else if (memcmp(f8.name,name,strlen(name))==0) {return f8.contents;}
    else if (memcmp(f9.name,name,strlen(name))==0) {return f9.contents;}
    else if (memcmp(f10.name,name,strlen(name))==0) {return f10.contents;}
    else if (memcmp(f11.name,name,strlen(name))==0) {return f11.contents;}
    else if (memcmp(f12.name,name,strlen(name))==0) {return f12.contents;}
    else if (memcmp(f13.name,name,strlen(name))==0) {return f13.contents;}
    else if (memcmp(f14.name,name,strlen(name))==0) {return f14.contents;}
    else if (memcmp(f15.name,name,strlen(name))==0) {return f15.contents;}
    else if (memcmp(f16.name,name,strlen(name))==0) {return f16.contents;}
    else if (memcmp(f17.name,name,strlen(name))==0) {return f17.contents;}
    else if (memcmp(f18.name,name,strlen(name))==0) {return f18.contents;}
    else if (memcmp(f19.name,name,strlen(name))==0) {return f19.contents;}
    else if (memcmp(f20.name,name,strlen(name))==0) {return f20.contents;}
    else if (memcmp(f21.name,name,strlen(name))==0) {return f21.contents;}
    else if (memcmp(f22.name,name,strlen(name))==0) {return f22.contents;}
    else if (memcmp(f23.name,name,strlen(name))==0) {return f23.contents;}
    else if (memcmp(f24.name,name,strlen(name))==0) {return f24.contents;}
    else if (memcmp(f25.name,name,strlen(name))==0) {return f25.contents;}
    else if (memcmp(f26.name,name,strlen(name))==0) {return f26.contents;}
    else if (memcmp(f27.name,name,strlen(name))==0) {return f27.contents;}
    else if (memcmp(f28.name,name,strlen(name))==0) {return f28.contents;}
    else if (memcmp(f29.name,name,strlen(name))==0) {return f29.contents;}
    else if (memcmp(f30.name,name,strlen(name))==0) {return f30.contents;}
    else if (memcmp(f31.name,name,strlen(name))==0) {return f31.contents;}
    else if (memcmp(f32.name,name,strlen(name))==0) {return f32.contents;}
    else if (memcmp(f33.name,name,strlen(name))==0) {return f33.contents;}
    else if (memcmp(f34.name,name,strlen(name))==0) {return f34.contents;}
    else if (memcmp(f35.name,name,strlen(name))==0) {return f35.contents;}
    else if (memcmp(f36.name,name,strlen(name))==0) {return f36.contents;}
    else if (memcmp(f37.name,name,strlen(name))==0) {return f37.contents;}
    else if (memcmp(f38.name,name,strlen(name))==0) {return f38.contents;}
    else if (memcmp(f39.name,name,strlen(name))==0) {return f39.contents;}
    else if (memcmp(f40.name,name,strlen(name))==0) {return f40.contents;}
    else if (memcmp(f41.name,name,strlen(name))==0) {return f41.contents;}
    else if (memcmp(f42.name,name,strlen(name))==0) {return f42.contents;}
    else if (memcmp(f43.name,name,strlen(name))==0) {return f43.contents;}
    else if (memcmp(f44.name,name,strlen(name))==0) {return f44.contents;}
    else if (memcmp(f45.name,name,strlen(name))==0) {return f45.contents;}
    else if (memcmp(f46.name,name,strlen(name))==0) {return f46.contents;}
    else if (memcmp(f47.name,name,strlen(name))==0) {return f47.contents;}
    else if (memcmp(f48.name,name,strlen(name))==0) {return f48.contents;}
    else if (memcmp(f49.name,name,strlen(name))==0) {return f49.contents;}
    else if (memcmp(f50.name,name,strlen(name))==0) {return f50.contents;}
    else if (memcmp(f51.name,name,strlen(name))==0) {return f51.contents;}
    else if (memcmp(f52.name,name,strlen(name))==0) {return f52.contents;}
    else if (memcmp(f53.name,name,strlen(name))==0) {return f53.contents;}
    else if (memcmp(f54.name,name,strlen(name))==0) {return f54.contents;}
    else if (memcmp(f55.name,name,strlen(name))==0) {return f55.contents;}
    else if (memcmp(f56.name,name,strlen(name))==0) {return f56.contents;}
    else if (memcmp(f57.name,name,strlen(name))==0) {return f57.contents;}
    else if (memcmp(f58.name,name,strlen(name))==0) {return f58.contents;}
    else if (memcmp(f59.name,name,strlen(name))==0) {return f59.contents;}
    else if (memcmp(f60.name,name,strlen(name))==0) {return f60.contents;}
    else if (memcmp(f61.name,name,strlen(name))==0) {return f61.contents;}
    else if (memcmp(f62.name,name,strlen(name))==0) {return f62.contents;}
    else if (memcmp(f63.name,name,strlen(name))==0) {return f63.contents;}

}
