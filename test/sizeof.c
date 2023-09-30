#include <stdio.h>
#include <string.h>
#include "../libc/mem/memcpy.h"
int main() {
   struct test {
    char jd[30];
   };
   struct test s1={"hi"};
   memcpy(s1.jd,"Hello",30);
   printf(s1.jd);
}