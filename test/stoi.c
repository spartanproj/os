#include <stdio.h>
int atoi(char * str) {
    int res = 0;
    for (int i = 0; str[i] != '\0'; ++i) {
        res = res * 10 + str[i] - '0';
    }
    return res;
}
 
// Driver Code
int main() {
    char str[] = "89789";
    int val = atoi(str);
    printf("%d ", val);
    return 0;
}