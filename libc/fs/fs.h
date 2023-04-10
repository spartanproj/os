#include "../mem/memcpy.h"
typedef struct fs_node {
    int perm;
    char contents[1024];
} nodes;
nodes roots={
    777,"Hello from root"
};
nodes info={
    777,"OS: NerdOS \n Version: v0.02 \"ffreestanding\" \n Devs: werdl;thisiscoding1234 \n \
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
        switch (file) {
            case 0:
                char previous[1024];
                memcpy(previous,root.o0.contents,1024);
                memcpy(root.o0.contents,strcat(previous,towrite),1024);
            case 1:
                char previous[1024];
                memcpy(previous,root.o1.contents,1024);
                memcpy(root.o1.contents,strcat(previous,towrite),1024);
            case 2:
                char previous[1024];
                memcpy(previous,root.o2.contents,1024);
                memcpy(root.o2.contents,strcat(previous,towrite),1024);
            case 3:
                char previous[1024];
                memcpy(previous,root.o3.contents,1024);
                memcpy(root.o3.contents,strcat(previous,towrite),1024);
            case 4:
                char previous[1024];
                memcpy(previous,root.o4.contents,1024);
                memcpy(root.o4.contents,strcat(previous,towrite),1024);
            case 5:
                char previous[1024];
                memcpy(previous,root.o5.contents,1024);
                memcpy(root.o5.contents,strcat(previous,towrite),1024);
            case 6:
                char previous[1024];
                memcpy(previous,root.o6.contents,1024);
                memcpy(root.o6.contents,strcat(previous,towrite),1024);
            case 7:
                char previous[1024];
                memcpy(previous,root.o7.contents,1024);
                memcpy(root.o7.contents,strcat(previous,towrite),1024);
            case 8:
                char previous[1024];
                memcpy(previous,root.o8.contents,1024);
                memcpy(root.o8.contents,strcat(previous,towrite),1024);
            case 9:
                char previous[1024];
                memcpy(previous,root.o9.contents,1024);
                memcpy(root.o9.contents,strcat(previous,towrite),1024);
        }

    }
}
nodes readfs(int file) {
    char * contentsof;
    int perm;
    switch (file) {
        case 0: contentsof=root.o0.contents;
        case 1: contentsof=root.o1.contents;
        case 2: contentsof=root.o2.contents;
        case 3: contentsof=root.o3.contents;
        case 4: contentsof=root.o4.contents;
        case 5: contentsof=root.o5.contents;
        case 6: contentsof=root.o6.contents;
        case 7: contentsof=root.o7.contents;
        case 8: contentsof=root.o8.contents;
        case 9: contentsof=root.o9.contents;
    }
    switch (file) {
        case 0: contentsof=root.o0.perm;
        case 1: contentsof=root.o1.perm;
        case 2: contentsof=root.o2.perm;
        case 3: contentsof=root.o3.perm;
        case 4: contentsof=root.o4.perm;
        case 5: contentsof=root.o5.perm;
        case 6: contentsof=root.o6.perm;
        case 7: contentsof=root.o7.perm;
        case 8: contentsof=root.o8.perm;
        case 9: contentsof=root.o9.perm;
    }
    nodes toret= {
        contentsof,perm
    };
    return toret;
}