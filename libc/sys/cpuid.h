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