#include "verification_stdlib.h"
void incr (unsigned int *p)
/*@ With (P : Z) Require P < 4294967295 && data_at(p,unsigned int,P) Ensure data_at(p,unsigned int,P + 1) */
{
  unsigned int n = *p;
  unsigned int m = n;
  *p = m;
}


void incr_first(unsigned int *p, unsigned int *q)
/*@ With (P : Z) (Q : Z) Require P < 4294967295 && data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,P + 1) * data_at(q,unsigned int,Q) */
{
  incr(p);
}


void incr_first_(unsigned int *p, unsigned int *q)
/*@ With (P : Z) Require P < 4294967295 && data_at(p,unsigned int,P) Ensure data_at(p,unsigned int,P + 1) */
{
  incr(p);
}
