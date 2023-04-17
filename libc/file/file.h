#include "alloc.h"
file newfile(char name[8], char contents[8]) {
    file newfile;
    memcpy(newfile.contents,contents,1024);
    memcpy(newfile.name,contents,1024);
    newfile.free=false;
    return newfile;
}
file writef(file writeto, char contents[1024], char mode) {
    if (mode=='w') {
        memcpy(writeto.contents,contents,1024);
        return writeto;
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