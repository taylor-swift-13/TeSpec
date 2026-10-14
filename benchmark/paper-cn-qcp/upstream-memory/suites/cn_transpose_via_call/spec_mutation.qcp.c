#include "verification_stdlib.h"
void swap (unsigned int *p, unsigned int *q)
/* --BEGIN-- */
/*@ With (P : Z) (Q : Z) Require data_at(p,unsigned int,P) * data_at(q,unsigned int,Q) Ensure data_at(p,unsigned int,Q) * data_at(q,unsigned int,P) */
/* --END-- */
{
  unsigned int m = *p;
  unsigned int n = *q;
  *p = n;
  *q = m;
}

struct point { unsigned int x; unsigned int y; };

void transpose2 (struct point *p)
/*@ With (X : Z) (Y : Z) Require data_at(&(p->x),unsigned int,X) * data_at(&(p->y),unsigned int,Y) Ensure data_at(&(p->x),unsigned int,Y + 1) * data_at(&(p->y),unsigned int,X) */
{
  swap(&p->x, &p->y);
}
