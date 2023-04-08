#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
size_t strlen(const char* str) 
{
	size_t len = 0;
	while (str[len])
		len++;
	return len;
}
bool computer=false;
bool human=false;
int toss() {
    int choice=rand()%2;
    if (choice==0) {
        computer=true;
        return 0;
    } else if (choice==1) {
        human=true;
        return 1;
    }
}
int comp(int lastnum) {
    int howmany=rand()%3;
    int nl;
    if (lastnum+howmany+1>=21) {
        printf("21");
        printf("Human wins! Good Job!");
        return -1;
    }
    if (howmany>=0) {
        printf("%d",lastnum+1);
        printf("\n");
        nl=lastnum+1;
    } if (howmany>=1) {
        printf("%d",lastnum+2);
        printf("\n");
        nl=lastnum+2;
    } if (howmany>=2) {
        printf("%d",lastnum+3);
        printf("\n");
        nl=lastnum+3;
    }
    if (nl>=21) {
        printf("Human wins! Good Job!");
        return -1;
    }
    return nl;
}
int hum(int lastnum) {
    int inputa;
    scanf("%d",&inputa);
    if (inputa==0) {
        printf("Please enter a number");
    } else {
        lastnum++;
    }
    if (lastnum==21) {
        printf("Computer wins! Good Job!");
        return -1;
    }

    inputa=0;
    scanf("%d",&inputa);

    if (inputa==0) {
        return lastnum;
    } else {
        lastnum++;
    }
    if (lastnum==21) {
        printf("Computer wins! Good Job!");
        return -1;
    }

    inputa=0;
    scanf("%d",&inputa);

    if (inputa==0) {
        return lastnum;
    } else {
        lastnum++;
    }
    if (lastnum==21) {
        printf("Computer wins! Good Job!");
        return -1;
    }
    return lastnum;
}
int main() {
    srand(time(NULL));
    int first=toss();
    // printf("%d",first);
    printf("Enter your numbers one by one, then type 0 when done.\n");
    if (computer==true) {
        int last=comp(0);
        while (last!=21) {
            int x=hum(last);
            last=comp(x);
            if (last==-1) {
                break;
                return 0;
            }
        }
    } else if (human==true) {
        int last = hum(0);
        while (last!=21) {
            int x=comp(last);
            last=hum(x);
            if (last==-1) {
                break;
                return 0;
            }
        }
    }
}