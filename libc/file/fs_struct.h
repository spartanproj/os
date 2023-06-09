enum users {
    ROOT=0,
    NORMAL=1,
    UNPRIV=2
};
#define FILE_MAX 65535 // max file size
#define NAME_MAX ((FILE_MAX+1)/4)-1 // atm 16383

#define NULL ((void*)0)

typedef struct filemetadata_s {
    bool rflag; // read ok then 1
    bool wflag; // write ok then 1
    bool hflag; // if hidden 1, else 0

    int creator; // enum value in users enum above
    int owner; // another enum value

    bool sysflag; // 0 for normal, 1 for system
    bool dflag; // 0 for delete ok, 1 for delete not ok
    int size; // current file size
    int maxsize; //max file size

    char * content; // file contents
    char * name;
} file_t;
unsigned strlen(const char * str); // io/tty.h
void panic(const char * debug, const char * msg, bool fatal); // kernel/abort.h

file_t create_readonly(char * content, char * name) {
    if (strlen(content)>FILE_MAX) {
        panic("content > FILE_MAX", "Maximum file length exceeded",0);
    }
    if (strlen(name)>NAME_MAX) {
        panic("content > FILE_MAX", "Maximum file length exceeded",0);
    }
    file_t temp = {
        1, // read - yes
        0, // write - no
        0, // hidden - no
        ROOT, // creator - root
        NORMAL, // owner - normal user
        0, // system - no
        0, // delete allowed - yes
        strlen(content), // length of content
        FILE_MAX, // maximum file length
        content, // content
        name // name of file
    };
    return temp;
}
char * readfile(file_t fs,char * name) {

}