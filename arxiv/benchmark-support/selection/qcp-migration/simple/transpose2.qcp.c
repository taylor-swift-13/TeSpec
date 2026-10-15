#include "verification_stdlib.h"

struct upoint { unsigned int x; unsigned int y; };

void swap (unsigned int *p, unsigned int *q)
/*@ With v w Require data_at(p, unsigned int, v) * data_at(q, unsigned int, w) Ensure data_at(p, unsigned int, w) * data_at(q, unsigned int, v) */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}

void transpose2 (struct upoint *p)
/*@ With x y Require data_at(&p->x, unsigned int, x) * data_at(&p->y, unsigned int, y) Ensure data_at(&p->x, unsigned int, y) * data_at(&p->y, unsigned int, x) */
{
  swap(&p->x, &p->y);
}
