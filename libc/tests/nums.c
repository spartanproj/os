#include <stdio.h>
#include <math.h>
int numlen(int arg) {
    if (arg>=1000000) return 6;
    if (arg>=100000) return 5;
    if (arg>=10000) return 4;
    if (arg>=1000) return 3;
    if (arg>=100) return 2;
    if (arg>=1) return 1;
    return 0;
}


char digstr(int digit) {
    switch (digit) {
        case 0: return '0';
        case 1: return '1';
        case 2: return '2';
        case 3: return '3';
        case 4: return '4';
        case 5: return '5';
        case 6: return '6';
        case 7: return '7';
        case 8: return '8';
        case 9: return '9';
    }
}

int getDigit(long n,int k){
    int i=0;
    long r =0;
    while(i<n){
        r=n%10;
        n=n/10;
        i++;
    }
    return r;
 }
const char atoi(int arg) {
    int len=numlen(arg);
    char buffer;
    int dig=getDigit(arg,1);
    char sdig =digstr(dig);
    return sdig;
}
int main() {
    digstr(4);
    printf("%s",atoi(443));
    // printf(atoi(443));
}