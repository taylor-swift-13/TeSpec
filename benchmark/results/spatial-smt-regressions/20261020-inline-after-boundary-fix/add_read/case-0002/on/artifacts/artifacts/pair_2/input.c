#include "verification_stdlib.h"

unsigned int add (unsigned int *p, unsigned int *q)

/*@ __tespec_entry With v w Require
      (p == (4096)) && (q == (8192)) && (v == (0)) && (w == (1)) && 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure __return == (v+w) % 4294967296 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) */
/*@ With v w Require 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure __return == (v+w) % 4294967296 && data_at(p, unsigned int, v) * data_at(q, unsigned int, w) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  return m+n;
}
