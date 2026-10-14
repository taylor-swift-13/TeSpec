#include "verification_stdlib.h"
unsigned int add (unsigned int *p, unsigned int *q)
/*@ With P Q Require P + Q <= 4294967295 && data_at(p, unsigned int, P) * data_at(q, unsigned int, Q) Ensure __return == P + Q && data_at(p, unsigned int, P) * data_at(q, unsigned int, Q) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  return m+n;
}
