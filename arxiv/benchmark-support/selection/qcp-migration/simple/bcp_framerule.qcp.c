#include "verification_stdlib.h"

void incr_first (unsigned int *p, unsigned int *q)
/*@ With v Require 0 <= v && v <= 4294967295 && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,(v+1)%4294967296) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}

void incr_first_frame (unsigned int *p, unsigned int *q)
/*@ With v w Require 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p,unsigned int,v) * data_at(q,unsigned int,w) Ensure data_at(p,unsigned int,(v+1)%4294967296) * data_at(q,unsigned int,w) */
{
  incr_first(p, q);
}
