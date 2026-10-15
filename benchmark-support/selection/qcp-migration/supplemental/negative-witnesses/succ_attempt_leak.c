#include <stdlib.h>
#include <stdio.h>
static int live; static void *last;
void *cn_malloc(unsigned long n){void*p=malloc(n);if(!p)exit(90);live++;last=p;return p;}
void cn_free_sized(void*p,unsigned long n){(void)n;free(p);live--;}
unsigned int *mallocUnsignedInt()
{
    return cn_malloc(sizeof(unsigned int));
}
void incr (unsigned int *p)
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}
unsigned int *refUnsignedInt (unsigned int v)
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}
unsigned int succ_using_incr_attempt(unsigned int n)
{
  unsigned int *p = refUnsignedInt(n);
  incr(p);
  return *p;
}
int main(void){unsigned int result=succ_using_incr_attempt(100);if(result!=101||live!=1)return 1;printf("result=%u live=%d\n",result,live); free(last);return 0;}
