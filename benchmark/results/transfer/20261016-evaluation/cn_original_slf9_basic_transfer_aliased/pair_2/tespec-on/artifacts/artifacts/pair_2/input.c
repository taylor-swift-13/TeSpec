#include "verification_stdlib.h"

void transfer (unsigned int *p, unsigned int *q)

/*@ __tespec_entry With v Require
      (p == (4096)) && (q == (4096)) && (v == (5)) && 0 <= v && v <= 4294967295 && p == q && data_at(p, unsigned int, v) Ensure data_at(p, unsigned int, 0) */
/*@ With v Require 0 <= v && v <= 4294967295 && p == q && data_at(p, unsigned int, v) Ensure data_at(p, unsigned int, 0) */
{
  unsigned int n = *p;
  unsigned int m = *q;
  unsigned int s = n + m;
  *p = s;
  *q = 0;
}
