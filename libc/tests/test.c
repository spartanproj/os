#include <stdio.h>

int itoa(int value, char *sp, int radix)
{
    char tmp[16];// be careful with the length of the buffer
    char *tp = tmp;
    int i;
    unsigned v;
    int sign = (radix == 10 && value < 0);    
    if (sign)
        v = -value;
    else
        v = (unsigned)value;

    while (v || tp == tmp)
    {
        i = v % radix;
        v /= radix;
        if (i < 10)
          *tp++ = i+'0';
        else
          *tp++ = i + 'a' - 10;
    }
    int len = tp - tmp;
    if (sign) 
    {
        *sp++ = '-';
        len++;
    }
    while (tp > tmp)
        *sp++ = *--tp;
    return len;
}
int main() {
    int a=9;
    char c=a+'0';
    char in_str[15];
    // itoap(0x35,in_str,10);
    
    printf("Converted character is %s",itoa(34,10));
}