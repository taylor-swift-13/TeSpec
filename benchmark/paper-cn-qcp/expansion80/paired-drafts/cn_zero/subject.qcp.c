#include "verification_stdlib.h"
void zero (unsigned int *p)
/* --BEGIN-- */
/*@ Require undef_data_at(p) Ensure data_at(p, unsigned int, 0) */
/* --END-- */
{
  *p = 0;
}
