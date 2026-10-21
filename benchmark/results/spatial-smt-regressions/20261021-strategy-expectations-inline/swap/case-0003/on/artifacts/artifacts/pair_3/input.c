#include "verification_stdlib.h"

void swap (unsigned int *p, unsigned int *q)

/*@ __tespec_entry With v w Require
      (p == (4096)) && (q == (8192)) && (v == (5)) && (w == (11)) && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, w) * data_at(q, unsigned int, v) */
/*@ With v w Require data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, w) * data_at(q, unsigned int, v) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}
