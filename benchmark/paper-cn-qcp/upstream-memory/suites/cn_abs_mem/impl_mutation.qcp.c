#include "verification_stdlib.h"
int abs_mem (int *p)
/* --BEGIN-- */
/*@ With (x : Z) Require INT_MIN < x && data_at(p, int, x) Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && data_at(p, int, x) */
/* --END-- */
{
  int x = *p;
  if (x >= 0) {
    return 0;
  }
  else {
    return -x;
  }
}
