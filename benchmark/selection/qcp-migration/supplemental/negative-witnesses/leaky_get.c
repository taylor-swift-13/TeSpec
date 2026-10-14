#include <stdlib.h>
#include <stdio.h>
static int live; static void *last;
void *cn_malloc(unsigned long n){void*p=malloc(n);if(!p)exit(90);live++;last=p;return p;}
void cn_free_sized(void*p,unsigned long n){(void)n;free(p);live--;}
unsigned int leaky_get (unsigned int *p)
{
  return *p;
}
int main(void){unsigned int *p=cn_malloc(4);*p=5;unsigned int result=leaky_get(p); if(result!=5||live!=1)return 1;printf("result=%u live=%d\n",result,live); free(last);return 0;}
