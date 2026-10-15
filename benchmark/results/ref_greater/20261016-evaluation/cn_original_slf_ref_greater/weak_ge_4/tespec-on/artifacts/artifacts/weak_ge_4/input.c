#include "verification_stdlib.h"

unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;

unsigned int *refUnsignedInt (unsigned int v)
/*@ With v0 Require 0 <= v0 && v0 <= 4294967295 && v == v0 && emp Ensure data_at(__return,unsigned int,v0) */
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

unsigned int *ref_greater_abstract (unsigned int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (4294967293)) && 0 <= v && v < 4294967295 && data_at(p,unsigned int,v) Ensure exists w, v <= w && data_at(p,unsigned int,v) * data_at(__return,unsigned int,w) */
/*@ With v Require 0 <= v && v < 4294967295 && data_at(p,unsigned int,v) Ensure exists w, v <= w && data_at(p,unsigned int,v) * data_at(__return,unsigned int,w) */
{
  unsigned int* q = mallocUnsignedInt();
  *q = *p + 1;
  return q;
}
