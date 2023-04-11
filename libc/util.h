int get_digits (int num)
{
   if(num < 10)
      return 1;

   if(num < 100)
      return 2;

    if(num < 1000)
      return 3;

    if(num < 10000)
      return 4;

    if(num < 100000)
      return 5;

    if(num < 1000000)
      return 6;

    if(num < 10000000)
      return 7;

    if(num < 100000000)
      return 8;

    if(num < 1000000000)
      return 9;

    return 10; /* num > 1000000000 */
}

const char * prnt(int number) {
  switch (number) {
    case 0:
      return "0";
    case 1:
      return "1";
    case 2:
      return "2";
    case -1:
      return "-1";
    case -2:
      return "-2";
  }
}
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
void printn(int num) {
  char buf[15];
  itoa(num,buf,10);
  printf(buf);
}
void printh(int num) {
  char buf[15];
  itoa(num,buf,16);
  printf(buf);
}
char *strcat(char *s1, const char *s2)
{
    //Pointer should not null pointer
    if((s1 == NULL) && (s2 == NULL))
        return NULL;
    //Create copy of s1
    char *start = s1;
    //Find the end of the destination string
    while(*start != '\0')
    {
        start++;
    }
    //Now append the source string characters
    //until not get null character of s2
    while(*s2 != '\0')
    {
        *start++ = *s2++;
    }
    //Append null character in the last
    *start = '\0';
    return s1;
}