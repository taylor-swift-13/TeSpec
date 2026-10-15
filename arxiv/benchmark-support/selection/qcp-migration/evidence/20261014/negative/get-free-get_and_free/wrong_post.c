#include "verification_stdlib.h"


unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, unsigned int) */;
void freeUnsignedInt(unsigned int *p)
/*@ Require undef_data_at(p, unsigned int) Ensure emp */;


unsigned int get_and_free (unsigned int *p)
/*@ With v0 Require data_at(p,unsigned int,v0) Ensure (__return == v0 && emp) && 0 == 1 */
{
  unsigned int v = *p;
  freeUnsignedInt (p);
  return v;
}
