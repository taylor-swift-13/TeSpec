#include <stdlib.h>
void *cn_malloc(unsigned long n){void*p=malloc(n);if(!p)exit(90);return p;}
void cn_free_sized(void*p,unsigned long n){(void)n;free(p);}
unsigned int deref(unsigned int *p)
{
  return *p;
}
int main()
{
    unsigned int *p = cn_malloc(sizeof(unsigned int));
    *p = 5;
    unsigned int x = deref(p);
    cn_free_sized(p, sizeof(unsigned int));
    cn_free_sized(p, sizeof(unsigned int));
return 0;
}
