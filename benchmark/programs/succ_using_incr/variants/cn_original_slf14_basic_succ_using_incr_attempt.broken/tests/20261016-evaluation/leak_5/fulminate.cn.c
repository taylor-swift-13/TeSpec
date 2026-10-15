// #include <limits.h>
// Generating C files from CN-annotated source... cn: internal error, uncaught exception:
//     End_of_file

#ifndef CN_UTILS
#include <stdlib.h>
void *cn_malloc(unsigned long size);
void cn_free_sized(void* p, unsigned long s);
#endif

unsigned int *mallocUnsignedInt()
/*@ trusted;
    ensures take v = Block<unsigned int>(return); !is_null(return); @*/
{
    return cn_malloc(sizeof(unsigned int));
}

// #include "slf0_basic_incr.c"

void incr (unsigned int *p)
/* --BEGIN-- */
/*@ requires take n1 = Owned<unsigned int>(p);
    ensures take n2 = Owned<unsigned int>(p);
            n2 == n1 + 1u32;
@*/
/* --END-- */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}

// #include "slf10_basic_ref.c"

unsigned int *refUnsignedInt (unsigned int v)
/*@ ensures take vr = Owned(return);
            vr == v;
@*/
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

unsigned int succ_using_incr_attempt(unsigned int n)
/* --BEGIN-- */
/*@ ensures return == n+1u32; 
@*/
/* --END-- */
{
  unsigned int *p = refUnsignedInt(n);
  incr(p);
  return *p;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int result = succ_using_incr_attempt(4294967295u); (void)result; return 0; }
