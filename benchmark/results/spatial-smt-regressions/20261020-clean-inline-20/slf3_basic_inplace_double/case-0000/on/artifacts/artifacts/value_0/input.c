#include "verification_stdlib.h"

void inplace_double (int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (-1073741824)) && -2147483648 <= 2*v && 2*v <= 2147483647 && data_at(p, int, v) Ensure data_at(p, int, 2*v) */
/*@ With v Require -2147483648 <= 2*v && 2*v <= 2147483647 && data_at(p, int, v) Ensure data_at(p, int, 2*v) */
{
  int n = *p;
  int m = n + n;
  *p = m;
}
