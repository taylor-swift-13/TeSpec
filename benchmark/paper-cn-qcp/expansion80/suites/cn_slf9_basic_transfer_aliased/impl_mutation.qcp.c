#include "verification_stdlib.h"
void transfer (unsigned int *p, unsigned int *q)
/*@ With P Require p == q && data_at(p, unsigned int, P) Ensure data_at(p, unsigned int, 0) */
{
  unsigned int n = *p;
  unsigned int m = *q;
  unsigned int s = n + m;
  *p = s;
  *q = 1;
}
