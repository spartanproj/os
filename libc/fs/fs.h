#include "../mem/memcpy.h"
typedef struct fs_node {
    char perm[3];
    char contents[1024];
} nodes;
nodes roots={
    "777","Hello from root"
};
nodes info={
    "777","OS: NerdOS \n Version: v0.02 \"ffreestanding\" \n Devs: werdl;thisiscoding1234 \n \
Github: spartanproj/os"
};
typedef struct fs {
    nodes o0;
    nodes o1;
    nodes o2;
    nodes o3;
    nodes o4;
    nodes o5;
    nodes o6;
    nodes o7;
    nodes o8;
    nodes o9;
    nodes info;
} fs_root;
fs_root root;
int fsinit() {
    root.info=info;
}
int writefs(char towrite[1024], char mode,int file) {
    if (mode=='w') {
        switch (file) {
            case 0: memcpy(root.o0.contents,towrite,1024);
            case 1: memcpy(root.o1.contents,towrite,1024);
            case 2: memcpy(root.o2.contents,towrite,1024);
            case 3: memcpy(root.o3.contents,towrite,1024);
            case 4: memcpy(root.o4.contents,towrite,1024);
            case 5: memcpy(root.o5.contents,towrite,1024);
            case 6: memcpy(root.o6.contents,towrite,1024);
            case 7: memcpy(root.o7.contents,towrite,1024);
            case 8: memcpy(root.o8.contents,towrite,1024);
            case 9: memcpy(root.o9.contents,towrite,1024);
        }
        return 0;
    }
    else if (mode=='a') {
        char previous[1024];
        switch (file) {
            case 0:
                memcpy(previous,root.o0.contents,1024);
                memcpy(root.o0.contents,strcat(previous,towrite),1024);
            case 1:
                memcpy(previous,root.o1.contents,1024);
                memcpy(root.o1.contents,strcat(previous,towrite),1024);
            case 2:
                memcpy(previous,root.o2.contents,1024);
                memcpy(root.o2.contents,strcat(previous,towrite),1024);
            case 3:
                memcpy(previous,root.o3.contents,1024);
                memcpy(root.o3.contents,strcat(previous,towrite),1024);
            case 4:
                memcpy(previous,root.o4.contents,1024);
                memcpy(root.o4.contents,strcat(previous,towrite),1024);
            case 5:
                memcpy(previous,root.o5.contents,1024);
                memcpy(root.o5.contents,strcat(previous,towrite),1024);
            case 6:
                memcpy(previous,root.o6.contents,1024);
                memcpy(root.o6.contents,strcat(previous,towrite),1024);
            case 7:
                memcpy(previous,root.o7.contents,1024);
                memcpy(root.o7.contents,strcat(previous,towrite),1024);
            case 8:
                memcpy(previous,root.o8.contents,1024);
                memcpy(root.o8.contents,strcat(previous,towrite),1024);
            case 9:
                memcpy(previous,root.o9.contents,1024);
                memcpy(root.o9.contents,strcat(previous,towrite),1024);
        }

    }
}
char * readfs(int file) {
    char * contentsof;
    switch (file) {
        case 0: memcpy(contentsof,root.o0.contents,1024);
        case 1: memcpy(contentsof,root.o1.contents,1024);
        case 2: memcpy(contentsof,root.o2.contents,1024);
        case 3: memcpy(contentsof,root.o3.contents,1024);
        case 4: memcpy(contentsof,root.o4.contents,1024);
        case 5: memcpy(contentsof,root.o5.contents,1024);
        case 6: memcpy(contentsof,root.o6.contents,1024);
        case 7: memcpy(contentsof,root.o7.contents,1024);
        case 8: memcpy(contentsof,root.o8.contents,1024);
        case 9: memcpy(contentsof,root.o9.contents,1024);
    }
    return contentsof;
}