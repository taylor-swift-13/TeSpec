#include "verification_stdlib.h"

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
