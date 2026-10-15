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

unsigned int *refUnsignedInt (unsigned int v)
/*@ ensures take vr = Owned(return);
            vr == v;
@*/
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

unsigned int *ref_greater_abstract (unsigned int *p)
/* --BEGIN-- */
/*@ requires take m1 = Owned<unsigned int>(p);
             m1 < 4294967295u32;
    ensures take m2 = Owned<unsigned int>(p);
            take n2 = Owned<unsigned int>(return);
            m1 == m2;
            m1 <= n2;
@*/
/* --END-- */
{
  unsigned int* q = mallocUnsignedInt();
  *q = *p + 1;
  return q;
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int frame=1u; unsigned int *q=ref_greater_abstract(&frame); cn_free_sized(q,sizeof(unsigned int)); return 0; }
