#include "verification_stdlib.h"


unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, unsigned int) */;
void cn_free_sized(void *p, unsigned long s)
/*@ Require s == 4 && undef_data_at(p,unsigned int) Ensure emp */;
void freeUnsignedInt (unsigned int *p)
/*@ Require undef_data_at(p,unsigned int) Ensure emp */
{
    cn_free_sized(p, sizeof(unsigned int));
}


unsigned int get_and_free (unsigned int *p)
/*@ With v0 Require data_at(p,unsigned int,v0) Ensure __return == v0 && emp */
{
  unsigned int v = *p;
  freeUnsignedInt (p);
  return v;
}
