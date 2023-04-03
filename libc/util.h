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
bool equals(char* tocheck[1024],const char * refstring) { //check string against ref
  for (int o=0;o<strlen(refstring);o++) {
    if (refstring[o]==tocheck[o]){}
    else return false;
  }
  return true;
}
bool instr(char ** tocheck, char * tofind) {
  int u=0;
  while (tocheck[u]!=tofind) {
    u++;
    if (u>strlen(tocheck)) {
      return false;
    }
  }
  return true;
}
void append(char * main, char * letter) {
  int x=strlen(main);
  main[x]=letter;
  main[x+1]="\0";
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