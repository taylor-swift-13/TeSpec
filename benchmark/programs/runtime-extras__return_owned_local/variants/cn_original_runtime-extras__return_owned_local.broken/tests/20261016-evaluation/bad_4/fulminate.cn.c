#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int get (unsigned int *p)
/*@
requires
    take v1_ = Owned(p);
ensures
    take v2 = Owned(p);
    v2 == v1_; return == v1_;
@*/
{
  return *p;
}


unsigned int **bad(unsigned int *p)
/*@ trusted;
requires
    take v1_ = Owned(p);
ensures
    take v2 = Owned(p);
    take p2 = Owned(return);
    ptr_eq(p, p2);
    v1_ == v2;
@*/
{
    return &p;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell=4294967294u; unsigned int **result=bad(&cell); (void)result; return 0; }
