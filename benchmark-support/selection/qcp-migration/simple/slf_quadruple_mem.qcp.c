#include "verification_stdlib.h"

int quadruple_mem (int *p)
/*@ With v Require -2147483648 <= 4*v && 4*v <= 2147483647 && data_at(p, int, v) Ensure __return == 4*v && data_at(p, int, v) */
{
  int m = *p + *p;
  return m + m;
}
