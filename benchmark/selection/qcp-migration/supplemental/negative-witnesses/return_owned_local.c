#include <stdio.h>
unsigned int **bad(unsigned int *p)
{
    return &p;
}
int main(void){unsigned int x=5;unsigned int **p=bad(&x);printf("%u\n",**p);return 0;}
