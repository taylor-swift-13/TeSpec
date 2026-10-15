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

unsigned int *refUnsignedInt (unsigned int v)
/*@ ensures take vr = Owned(return);
            vr == v;
@*/
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

unsigned int *triple_ref_with_frame(unsigned int *p_, unsigned int v)
/* --BEGIN-- */
/*@ requires take v_1 = Owned(p_);
    ensures  take v_2 = Owned(p_);
             v_2 == v_1;
             take vr = Owned(return);
             vr == v;
@*/
/* --END-- */
{
  return refUnsignedInt(v);
}

int main(void) /*@ ensures return == 0i32; @*/ { unsigned int frame=11u; unsigned int *q=triple_ref_with_frame(&frame,5u); cn_free_sized(q,sizeof(unsigned int)); return 0; }
