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
char *itoa (int n)

{
    static char temp[10]; // MN that can be replaced by some def?
    int nDigits = 0;
    int i = 0;
 
    if(n == 0)
    {
        temp[0] = '0';
        temp[1] = '\0';
 
       return temp; // or just return "0"; ?
    }
 
    nDigits = get_digits(n); // fast function to count digits..
 
    temp[nDigits] = '\0'; // ..needed just here
 

   for(i = n; i >= 1; i /= 10) // whole method stinks
    {
        temp[--nDigits] = ((i % 10) + '0'); // modulo is quite slow
    }
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
  for (int o=0;o<1024;o++) {
    if (refstring[o]==tocheck[o]){}
    else return false;
  }
  return true;
}