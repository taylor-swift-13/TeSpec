#include "verification_stdlib.h"
unsigned int double_it (unsigned int *p)
/* --BEGIN-- */
/*@ With P Require P + P <= 4294967295 && data_at(p, unsigned int, P) Ensure __return == P + P && data_at(p, unsigned int, P) */
/* --END-- */
{
  unsigned int n = *p;
  unsigned int m = n + n;
  return n;
}
