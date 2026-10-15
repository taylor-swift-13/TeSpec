#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int leaky_get (unsigned int *p)
/*@ trusted;
requires
    take v1_ = Owned(p);
ensures
    return == v1_;
@*/
{
  return *p;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int cell=4294967295u; unsigned int result=leaky_get(&cell); (void)result; return 0; }
