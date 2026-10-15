#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int *mkref(unsigned int x)
/*@ trusted;
requires
    true;
ensures
    take v1_ = Owned(return);
    v1_ == x;
@*/
{
  unsigned int *p = cn_malloc(sizeof(unsigned int));
  *p = x;
  return p;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int *p=mkref(5u); cn_free_sized(p,sizeof(unsigned int)); return 0; }
