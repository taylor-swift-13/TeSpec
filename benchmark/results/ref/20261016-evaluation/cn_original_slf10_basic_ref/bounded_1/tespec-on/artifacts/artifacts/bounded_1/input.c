#include "verification_stdlib.h"


unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, unsigned int) */;
void freeUnsignedInt(unsigned int *p)
/*@ Require undef_data_at(p, unsigned int) Ensure emp */;


unsigned int *refUnsignedInt (unsigned int v)

/*@ __tespec_entry With v0 Require
      (v == (1)) && (v0 == (1)) && 0 <= v0 && v0 <= 4294967295 && v == v0 && emp Ensure data_at(__return, unsigned int, v0) */
/*@ With v0 Require 0 <= v0 && v0 <= 4294967295 && v == v0 && emp Ensure data_at(__return, unsigned int, v0) */
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}
