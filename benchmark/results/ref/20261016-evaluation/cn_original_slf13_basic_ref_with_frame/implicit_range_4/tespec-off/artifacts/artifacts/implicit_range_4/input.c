#include "verification_stdlib.h"


unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, unsigned int) */;
void freeUnsignedInt(unsigned int *p)
/*@ Require undef_data_at(p, unsigned int) Ensure emp */;


unsigned int *refUnsignedInt (unsigned int v)
/*@ With v0 Require v == v0 && emp Ensure data_at(__return, unsigned int, v0) */
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

unsigned int *triple_ref_with_frame(unsigned int *p_, unsigned int v)

/*@ __tespec_entry With old v0 Require
      (p_ == (4096)) && (v == (4294967294)) && (old == (1)) && (v0 == (4294967294)) && v == v0 && data_at(p_,unsigned int,old) Ensure data_at(p_,unsigned int,old) * data_at(__return,unsigned int,v0) */
/*@ With old v0 Require v == v0 && data_at(p_,unsigned int,old) Ensure data_at(p_,unsigned int,old) * data_at(__return,unsigned int,v0) */
{
  return refUnsignedInt(v);
}
