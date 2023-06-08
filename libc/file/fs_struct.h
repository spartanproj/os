enum users {
    ROOT=0,
    NORMAL=1,
    UNPRIV=2
};
#define FILE_MAX 65535 // max file size
#define NAME_MAX ((FILE_MAX+1)/4)-1
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

    char content[FILE_MAX]; // file contents
    char name[NAME_MAX];
} file_t;
unsigned strlen(const char * str);
file_t create(char content[FILE_MAX], char name[NAME_MAX]) {
    file_t temp = {
        1,
        1,
        0,
        ROOT,
        NORMAL,
        0,
        0,
        strlen(content),
        FILE_MAX,
        //finsih later
    };
}