enum users {
    ROOT=0,
    NORMAL=1,
    UNPRIV=2
};
#define FILE_MAX 65535 // max file size
#define NAME_MAX ((FILE_MAX+1)/4)-1 // atm 16383

typedef struct filemetadata_s {
    bool rflag; // read ok then 1
    bool wflag; // write ok then 1
    bool hflag; // if hidden 1, else 0

    int creator; // enum value in users enum above
    int owner; // another enum value

    bool sysflag; // 0 for normal, 1 for system
    bool dflag; // 0 for delete ok, 1 for delete not ok
    int maxsize; //max file size

    char * content; // file contents
    char * name;
} file_t;
size_t strlen(const char * str); // io/tty.h
void panic(const char * debug, const char * msg, bool fatal); // kernel/abort.h

int create_readonly(char * content, char * name,file_t *file) {
    if (strlen(content)>FILE_MAX) {
        panic("content > FILE_MAX", "Maximum file length exceeded",0);
    }
    if (strlen(name)>NAME_MAX) {
        panic("content > FILE_MAX", "Maximum file length exceeded",0);
    }
    // file_t temp = {
    //     1, // read - yes
    //     0, // write - no
    //     0, // hidden - no
    //     ROOT, // creator - root
    //     NORMAL, // owner - normal user
    //     0, // system - no
    //     0, // delete allowed - yes
    //     FILE_MAX, // maximum file length
    //     content, // content
    //     name // name of file
    // };
    file->rflag=1;
    file->wflag=0;
    file->hflag=0;
    file->creator=ROOT;
    file->owner=NORMAL;
    file->sysflag=0;
    file->dflag=0;
    file->maxsize=FILE_MAX;
    file->content=content;
    file->name=name;
    return 0;
}
// list of create_readonly calls generated at build time by fsinit.py