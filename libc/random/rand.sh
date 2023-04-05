export rand=$(date +%s)
echo "
static unsigned long int next = 1;  // NB: "unsigned long int" is assumed to be 32 bits wide
 
int rand(void)  // RAND_MAX assumed to be 32767
{
    next = next * 1103515245 + 12345;
    return (unsigned int) (next / 65536) % 32768;
}
 
void srand(unsigned int seed)
{
    next = seed;
}
unsigned int rnd=" > $1.h
echo $rand >> $1.h
echo ";" >> $1.h