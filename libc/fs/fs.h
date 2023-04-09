typedef struct fs_node {
    int perm;
    char contents[1024];
} node;
node root={
    777,"Hello from root"
};
node info={
    777,"OS: NerdOS \n Version: v0.02 \"ffreestanding\" \n Devs: werdl;thisiscoding1234 \n \
Github: spartanproj/os"
};