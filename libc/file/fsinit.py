from os import listdir,chdir
from os.path import isfile, join
import sys
location="../../initrd"
chdir("libc/file")
onlyfiles = [f for f in listdir(location) if isfile(join(location, f))]
try:
    with open("initrd.h","w") as initrd:
        after=""
        initrd.write("""
struct node {
    file_t data;
    struct node * next;
};
struct node * head=NULL;
struct node * current=NULL;

void printlist() {
    struct node * ptr=head;

    while (ptr!=NULL) {
        printf("\\n");
        printf((ptr->data).name);
        printf("=>");
        printf((ptr->data).content);
        ptr=ptr->next;
    }
    printf("\\n");
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
""")
        for file in onlyfiles:
            filef=file.replace(".","")
            with open(location+"/"+file,"r") as file_contents:
                # print(str(file_contents.readlines()).replace("[","").replace("'","").replace(","," \ \n").replace("]",""))
                tempf=(str(file_contents.readlines()).replace("[","").replace("'","").replace(",","\\\n").replace("]",""))
                print(tempf)
                initrd.write(f"file_t fil_{filef};")
                after+=f"\ncreate_readonly(\"{tempf}\",\"{file}\",&fil_{filef});\ninsert(fil_{filef});\n"
        initrd.write("void createfiles() {")
        initrd.write(after)
        initrd.write("}\n")
except Exception as e:
    sys.panic(f" Error from python: {Exception}")
    