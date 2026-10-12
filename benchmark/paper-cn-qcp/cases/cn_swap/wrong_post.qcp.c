#include "verification_stdlib.h"
void swap (unsigned int *p, unsigned int *q)
/*@ With P Q Require data_at(p, unsigned int, P) * data_at(q, unsigned int, Q) Ensure data_at(p, unsigned int, P) * data_at(q, unsigned int, Q) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}
