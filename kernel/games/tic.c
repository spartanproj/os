
int printt(int inp) {
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
int tries=0;
int render(int tl, int tm, int tr,
           int ml, int mm, int mr,
           int bl, int bm, int br){
    printt(tl);
    printf(" ");
    printt(tm);
    printf(" ");
    printt(tr);
    printf("\n");

    printt(ml);
    printf(" ");
    printt(mm);
    printf(" ");
    printt(mr);
    printf(" -- ");
    printn(tries);
    printf("\n");

    printt(bl);
    printf(" ");
    printt(bm);
    printf(" ");
    printt(br);
    printf("\n");
    printf("_____\n");
}
char * toreturn[9]={
        "tl","tm","tr","ml","mm","mr","bl","bm","br"
    };
int p[]={3,3,3,
         3,3,3,
         3,3,3};
int winner=3;
bool checkwin() {
    if ((p[0]==0&&p[1]==0&&p[2]==0) || (p[0]==1&&p[1]==1&&p[2]==1)) return true; //top row
    else if ((p[3]==0&&p[4]==0&&p[5]==0) || (p[3]==1&&p[4]==1&&p[5]==1)) return true; //middle row
    else if ((p[6]==0&&p[7]==0&&p[8]==0) || (p[6]==1&&p[7]==1&&p[8]==1)) return true; //bottom row

    else if ((p[0]==0&&p[3]==0&&p[6]==0) || (p[0]==1&&p[3]==1&&p[6]==1)) return true; //left column
    else if ((p[1]==0&&p[4]==0&&p[7]==0) || (p[1]==1&&p[4]==1&&p[7]==1)) return true; //middle column
    else if ((p[2]==0&&p[5]==0&&p[8]==0) || (p[2]==1&&p[5]==1&&p[8]==1)) return true; //right column

    else if (((p[0]==0&&p[4]==0&&p[8]==0) || (p[0]==1&&p[4]==1&&p[8]==1))) return true; //TL to BR
    else if (((p[2]==0&&p[4]==0&&p[6]==0) || (p[2]==1&&p[4]==1&&p[6]==1))) return true;
    else return false;
}
char * getInput() {
    int y=rand()%10;
    int raw=y;
    char * inp=toreturn[raw];
    if (p[raw]!=3) {
        getInput();
    } else {
        return inp;
    }
}
void win(int move) {
    if (move==1) {
        printf("Victory for Noughts O, on go number ");
        printn(tries-1);
    } else if (move==0) {
        printf("Victory for crosses X, on go number ");
        printn(tries-1);
    } else if (move==-1) {
        printf("Nobody wins.");
    }
}
int tic() {
    for (int a=0;a<9;a++) {
        p[a]=3;
    }
    tries=0;
    clear();
    clear_screen();
    srand(rnd);
    int u=0;
    printf(" #######             #######                  #######               \n");
    printf("    #    #  ####        #      ##    ####        #     ####  ###### \n");
    printf("    #    # #    #       #     #  #  #    #       #    #    # #      \n");
    printf("    #    # #            #    #    # #            #    #    # #####  \n");
    printf("    #    # #            #    ###### #            #    #    # #      \n");
    printf("    #    # #    #       #    #    # #    #       #    #    # #      \n");
    printf("    #    #  ####        #    #    #  ####        #     ####  ###### ");         
    while (u<65000000) {
		u++;
		printf("\0");
	}
    clear();
    clear_screen();
    
    // render(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8]);
    
    int move=0;
    bool faile=false;
    while (1) {
        whil:
        
        if (faile==true) {
            faile=false;
        } else {
            tries++;
        }
        move=tries%2;
        char * inp;
        if (checkwin()==true) {
            win(move);
            break;
        }
        
        if (tries>9) {
            win(-1);
            break;
        } else {
            inp=getInput();
        }
        
        
        
        if(inp=="tl" && p[0]==3){
            p[0]=move;
        } else if(inp== "tm" && p[1]==3){
            p[1]=move;
        } else if(inp== "tr" && p[2]==3){
            p[2]=move;
        } else if(inp== "ml" && p[3]==3){
            p[3]=move;
        } else if(inp== "mm" && p[4]==3){
            p[4]=move;
        } else if(inp== "mr" && p[5]==3){
            p[5]=move;
        } else if(inp== "bl" && p[6]==3){
            p[6]=move;
        } else if(inp== "bm"&& p[7]==3){
            p[7]=move;
        } else if(inp== "br"&& p[8]==3){
            p[8]=move;
        } else {
            faile=true;
            goto whil;
        }
        int i=0;
        
        render(p[0],p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8]);
        while (i<35000000) {
		i++;
		printf("\0");
	    }
        clear();
        clear_screen();
        // printf("%s",inp);
        // printf("\n");
    }
    
}