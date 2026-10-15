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

void incr (unsigned int *p)
/*@ With n0 Require data_at(p, unsigned int, n0) Ensure data_at(p, unsigned int, (n0 + 1) % 4294967296) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}

unsigned int succ_using_incr (unsigned int n)

/*@ __tespec_entry With n0 Require
      (n == (0)) && (n0 == (0)) && n == n0 && emp Ensure __return == (n0+1) % 4294967296 && emp */
/*@ With n0 Require n == n0 && emp Ensure __return == (n0+1) % 4294967296 && emp */
{
  unsigned int *p = refUnsignedInt(n);
  incr(p);
  unsigned int x = *p;
  freeUnsignedInt(p);
  return x;
}
