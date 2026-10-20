#include "verification_stdlib.h"

struct point { int x; int y; };

void transpose (struct point *p)

/*@ __tespec_entry With x y Require
      (p == (4096)) && (x == (42)) && (y == (42)) && data_at(&p->x, int, x) * data_at(&p->y, int, y) Ensure data_at(&p->x, int, y) * data_at(&p->y, int, x) */
/*@ With x y Require data_at(&p->x, int, x) * data_at(&p->y, int, y) Ensure data_at(&p->x, int, y) * data_at(&p->y, int, x) */
{
  int temp_x = p->x;
  int temp_y = p->y;
  p->x = temp_y;
  p->y = temp_x;
}
