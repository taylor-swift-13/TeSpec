#include <stdlib.h>
void *cn_malloc(unsigned long n){void*p=malloc(n);if(!p)exit(90);return p;}
void cn_free_sized(void*p,unsigned long n){(void)n;free(p);}
void bad_free(int *p)
{
    cn_free_sized(p, sizeof(int));
}
int main(void){bad_free((int*)1);return 0;}
