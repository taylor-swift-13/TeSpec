#include "verification_stdlib.h"
void incr (unsigned int *p)
/*@ With P Require P < 4294967295 && data_at(p, unsigned int, P) Ensure data_at(p, unsigned int, P + 1) */
{
  unsigned int n = *p;
  unsigned int m = n;
  *p = m;
}
