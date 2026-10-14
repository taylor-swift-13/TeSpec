#include "verification_stdlib.h"
void inplace_double (unsigned int *p)
/* --BEGIN-- */
/*@ With P Require P + P <= 4294967295 && data_at(p, unsigned int, P) Ensure data_at(p, unsigned int, P + P) */
/* --END-- */
{
  unsigned int n = *p;
  unsigned int m = n + n;
  *p = m;
}
