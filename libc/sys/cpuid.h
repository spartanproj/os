void cpuid(int *peax, int *pebx, int *pecx, int *pedx)
{
    __asm(
         "CPUID"
          /* All outputs (eax, ebx, ecx, edx) */
        : "=a"(*peax), "=b"(*pebx), "=c"(*pecx), "=d"(*pedx)   
          /* All inputs (eax) */
        : "a"(*peax)                                           
    );
}
#include <cpuid.h>
 
/* Example: Get CPU's model number */
static int get_model(void)
{
    int ebx, unused;
    __cpuid(0, unused, ebx, unused, unused);
    return ebx;
}
static inline int cpuid_string(int code, uint32_t where[4]) {
  asm volatile("cpuid":"=a"(*where),"=b"(*(where+1)),
               "=c"(*(where+2)),"=d"(*(where+3)):"a"(code));
  return (int)where[0];
}