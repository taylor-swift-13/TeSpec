#include "verification_stdlib.h"

void swap (unsigned int *p, unsigned int *q)
/*@ With v w Require data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, w) * data_at(q, unsigned int, v) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}
