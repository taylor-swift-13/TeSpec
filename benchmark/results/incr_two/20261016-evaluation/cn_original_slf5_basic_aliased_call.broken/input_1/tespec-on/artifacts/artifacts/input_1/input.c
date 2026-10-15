#include "verification_stdlib.h"
void incr (unsigned int *p)
/*@ With v Require 0 <= v && v <= 4294967295 && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,(v+1)%4294967296) */
{
  unsigned int n = *p;
  unsigned int m = n+1;
  *p = m;
}
void incr_two (unsigned int *p, unsigned int *q)
/*@ With v w Require 0 <= v && v <= 4294967295 && 0 <= w && w <= 4294967295 && data_at(p,unsigned int,v) * data_at(q,unsigned int,w) Ensure data_at(p,unsigned int,(v+1)%4294967296) * data_at(q,unsigned int,(w+1)%4294967296) */
{
  incr(p);
  incr(q);
}
void aliased_call (unsigned int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (4294967295)) && 0 <= v && v <= 4294967295 && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,(v+2)%4294967296) */
/*@ With v Require 0 <= v && v <= 4294967295 && data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,(v+2)%4294967296) */
{
  incr_two(p, p);
}
