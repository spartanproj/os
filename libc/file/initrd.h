
struct node {
    file_t data;
    struct node * next;
};
struct node * head=NULL;
struct node * current=NULL;

void printlist() {
    struct node * ptr=head;

    while (ptr!=NULL) {
        printf("\n");
        printf((ptr->data).name);
        printf("=>");
        printf((ptr->data).content);
        ptr=ptr->next;
    }
    printf("\n");
}
char * search(char * name) {
    struct node * ptr=head;

    while (ptr!=NULL) {
        if(!memcmp((ptr->data).name,name,strlen(name))) {
            return (ptr->data).content;
        }
        ptr=ptr->next;
    }
    return "Not found";
}
void insert(file_t data) {
   struct node * link = (struct node *) kmalloc(sizeof(struct node));
   link->data = data;
   link->next = head;
   head = link;
}
file_t fil_test1txt;file_t fil_test2txt;file_t fil_colorconf;file_t fil_boot_timeconf;void createfiles() {
create_readonly("hellO!\n\
 hi","test1.txt",&fil_test1txt);
insert(fil_test1txt);

create_readonly("bjasbj","test2.txt",&fil_test2txt);
insert(fil_test2txt);

create_readonly("BORE","color.conf",&fil_colorconf);
insert(fil_colorconf);

create_readonly("5","boot_time.conf",&fil_boot_timeconf);
insert(fil_boot_timeconf);
}
