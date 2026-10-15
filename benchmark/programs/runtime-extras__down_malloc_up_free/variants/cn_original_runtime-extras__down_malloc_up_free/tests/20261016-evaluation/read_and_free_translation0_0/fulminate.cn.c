#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int read_and_free(unsigned int *p)
/*@ trusted;
requires
    take v1_ = Owned(p);
ensures
    return == v1_;
@*/
{
  unsigned int result = *p;
  cn_free_sized(p, sizeof(unsigned int));
  return result;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int *p=cn_malloc(sizeof(unsigned int)); *p=0u; unsigned int result=read_and_free(p); (void)result; return 0; }
