#include "verification_stdlib.h"

struct tuple {
  int x;
  int y;
};

int abs_mem (int *p)
/*@ With v Require -2147483648 < v && data_at(p, int, v) Ensure ((v >= 0 && __return == v) || (v < 0 && __return == -v)) && data_at(p, int, v) */
{
  int x = *p;
  if (x >= 0) {
    return x;
  }
  else {
    return -x;
  }
}

int abs_y (struct tuple *p)

/*@ __tespec_entry With x y Require
      (p == (4096)) && (x == (-1)) && (y == (0)) && -2147483648 < y && data_at(&p->x, int, x) * data_at(&p->y, int, y) Ensure ((y >= 0 && __return == y) || (y < 0 && __return == -y)) && data_at(&p->x, int, x) * data_at(&p->y, int, y) */
/*@ With x y Require -2147483648 < y && data_at(&p->x, int, x) * data_at(&p->y, int, y) Ensure ((y >= 0 && __return == y) || (y < 0 && __return == -y)) && data_at(&p->x, int, x) * data_at(&p->y, int, y) */
{
  return abs_mem(&p->y);
}
