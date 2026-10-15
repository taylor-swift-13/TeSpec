#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

#include <limits.h>

// #include "free.h"

void freeUnsignedInt (unsigned int *p)
/*@ requires take v = Block<unsigned int>(p);
    ensures true;
@*/
{
    cn_free_sized(p, sizeof(unsigned int));
}

unsigned int get_and_free (unsigned int *p)
/*@ requires take v1_ = Owned(p);
    ensures return == v1_; @*/
{
  unsigned int v = *p;
  freeUnsignedInt (p);
  return v;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int *p=cn_malloc(sizeof(unsigned int)); *p=1u; unsigned int result=get_and_free(p); return 0; }
