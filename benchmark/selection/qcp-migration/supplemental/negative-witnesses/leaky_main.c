#include <stdlib.h>
#include <stdio.h>
static int live; static void *last;
void *cn_malloc(unsigned long n){void*p=malloc(n);if(!p)exit(90);live++;last=p;return p;}
void cn_free_sized(void*p,unsigned long n){(void)n;free(p);live--;}
unsigned int *mkref(unsigned int x)
{
  unsigned int *p = cn_malloc(sizeof(unsigned int));
  *p = x;
  return p;
}
int main(void){unsigned int *p=mkref(5);if(*p!=5||live!=1)return 1;printf("value=%u live=%d\n",*p,live); free(last);return 0;}
