/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
struct Node{
    char * value;
    struct Node * Next;
    struct Node * Previous;
};
struct List{
    int Count;
    int Total;
    struct Node * first;
    struct Node * last;
};
typedef struct List list_t;
