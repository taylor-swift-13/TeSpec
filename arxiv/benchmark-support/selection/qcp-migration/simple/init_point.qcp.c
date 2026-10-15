#include "verification_stdlib.h"

struct point { int x; int y; };

void zero (int *p)
/*@ Require undef_data_at(p, int) Ensure data_at(p, int, 0) */
{
  *p = 0;
}

void init_point(struct point *p)
/*@ Require undef_data_at(&p->x, int) * undef_data_at(&p->y, int) Ensure data_at(&p->x, int, 0) * data_at(&p->y, int, 0) */
{
  zero(&p->x);
  zero(&p->y);
}
