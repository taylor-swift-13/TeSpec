#include "verification_stdlib.h"

void transfer (unsigned int *p, unsigned int *q)
/*@ With v w Require 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, (v+w) % 4294967296) * data_at(q, unsigned int, 0) */
{
  unsigned int n = *p;
  unsigned int m = *q;
  unsigned int s = n + m;
  *p = s;
  *q = 0;
}
