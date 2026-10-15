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

unsigned int *ref_greater (unsigned int *p)

/*@ __tespec_entry With n0 Require
      (p == (4096)) && (n0 == (0)) && data_at(p,unsigned int,n0) Ensure exists m, m == (n0+1) % 4294967296 && data_at(p,unsigned int,n0) * data_at(__return,unsigned int,m) */
/*@ With n0 Require data_at(p,unsigned int,n0) Ensure exists m, m == (n0+1) % 4294967296 && data_at(p,unsigned int,n0) * data_at(__return,unsigned int,m) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  return refUnsignedInt(m);
}
