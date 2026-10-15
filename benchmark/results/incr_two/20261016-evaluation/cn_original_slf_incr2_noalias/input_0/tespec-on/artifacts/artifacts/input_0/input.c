#include "verification_stdlib.h"

void incr2a (unsigned int *p, unsigned int *q)

/*@ __tespec_entry With v w Require
      (p == (4096)) && (q == (8192)) && (v == (0)) && (w == (0)) && 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, (v+1) % 4294967296) * data_at(q, unsigned int, (w+1) % 4294967296) */
/*@ With v w Require 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, (v+1) % 4294967296) * data_at(q, unsigned int, (w+1) % 4294967296) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
  n = *q;
  m = n+1;
  *q = m;
}
