#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int deref(unsigned int *p)
/*@ trusted;
requires
    take v1_ = Owned(p);
ensures
    take v2 = Owned(p);
    v1_ == v2;
    return == v1_;
@*/
{
  return *p;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell=4294967295u; unsigned int result=deref(&cell); (void)result; return 0; }
