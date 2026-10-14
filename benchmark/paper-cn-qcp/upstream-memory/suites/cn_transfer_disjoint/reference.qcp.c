#include "verification_stdlib.h"
void transfer (unsigned int *p, unsigned int *q)
/* --BEGIN-- */
/*@ With (P : Z) (Q : Z) Require P + Q <= 4294967295 && data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,P + Q) * data_at(q,unsigned int,0) */
/* --END-- */
{
  unsigned int n = *p;
  unsigned int m = *q;
  unsigned int s = n + m;
  *p = s;
  *q = 0;
}
