#include "verification_stdlib.h"
int abs_mem (int *p)
/* --BEGIN-- */
/*@ With (x : Z) Require INT_MIN < x && data_at(p, int, x) Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && data_at(p, int, x) */
/* --END-- */
{
  int x = *p;
  if (x >= 0) {
    return x;
  }
  else {
    return -x;
  }
}



struct tuple {
  int x;
  int y;
};


int abs_y (struct tuple *p)
/*@ With (X : Z) (Y : Z) Require INT_MIN < Y && data_at(&(p->x),int,X) * data_at(&(p->y),int,Y) Ensure ((Y >= 0 && __return == Y) || (Y < 0 && __return == -Y)) && data_at(&(p->x),int,X) * data_at(&(p->y),int,Y) */
{
  return abs_mem(&p->x);
}
