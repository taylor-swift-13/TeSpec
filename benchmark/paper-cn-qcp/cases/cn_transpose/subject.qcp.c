#include "verification_stdlib.h"
struct point { unsigned int x; unsigned int y; };
void transpose (struct point *p)
/*@ With x y Require data_at(&(p->x), unsigned int, x) * data_at(&(p->y), unsigned int, y) Ensure data_at(&(p->x), unsigned int, y) * data_at(&(p->y), unsigned int, x) */
{
  unsigned int temp_x = p->x;
  unsigned int temp_y = p->y;
  p->x = temp_y;
  p->y = temp_x;
}
