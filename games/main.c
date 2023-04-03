#include <stdio.h>
#include <time.h>
#include <stdlib.h>
int prnt(int inp) {
    if (inp==3) {
        printf("-");
    }
    else if (inp==1) {
        printf("X");
    } else if (inp==0) {
        printf("O");
    } else {
        return 1;
    } return 0;
}
int render(int tl, int tm, int tr,
           int ml, int mm, int mr,
           int bl, int bm, int br){
    prnt(tl);
    printf(" ");
    prnt(tm);
    printf(" ");
    prnt(tr);
    printf("\n");

    prnt(ml);
    printf(" ");
    prnt(mm);
    printf(" ");
    prnt(mr);
    printf("\n");

    prnt(bl);
    printf(" ");
    prnt(bm);
    printf(" ");
    prnt(br);
    printf("\n");
}
int counter=-1;
char * getInput() {
    char * toreturn[9]={
        "tl","tm","tr","ml","mm","mr","bl","bm","br"
    };
    counter++;
    return toreturn[rand()%9];
}
int main(int argc, char ** argv) {
    srand(time(NULL));
    render(3,3,3,3,3,3,3,3,3);
    int p[]={3,3,3,
              3,3,3,
              3,3,3};
    // render(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8]);
    printf("_____\n");
    int move=0;
    int tries=0;
    while (1) {
        move=tries%2;
        tries++;
        if (tries>8) return 0;
    char * inp=getInput();
        if(inp=="tl" && p[0]==3){
            p[0]=move;
        } if(inp== "tm" && p[1]==3){
            p[1]=move;
        } if(inp== "tr" && p[2]==3){
            p[2]=move;

        } if(inp== "ml" && p[3]==3){
            p[3]=move;
        } if(inp== "mm" && p[4]==3){
            p[4]=move;
        } if(inp== "mr" && p[5]==3){
            p[5]=move;

        } if(inp== "bl" && p[6]==3){
            p[6]=move;
        } if(inp== "bm"&& p[7]==3){
            p[7]=move;
        } if(inp== "br"&& p[8]==3){
            p[8]=move;
        }
        
        render(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8]);
    }
    
}