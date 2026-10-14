#include "verification_stdlib.h"
void zero (unsigned int *coord) 
/*@ With (Coord : Z) Require data_at(coord, unsigned int, Coord) Ensure data_at(coord, unsigned int, 0) */
{
  *coord = 0;
}

struct point { unsigned int x; unsigned int y; };

void init_point(struct point *p) 
/*@ With (X : Z) (Y : Z) Require data_at(&(p->x),unsigned int,X) * data_at(&(p->y),unsigned int,Y) Ensure data_at(&(p->x),unsigned int,1) * data_at(&(p->y),unsigned int,0) */
{
  zero(&p->x);
  zero(&p->y);
}
