#include "verification_stdlib.h"

void incr (int *p)

/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (2147483646)) && v+1 <= 2147483647 && data_at(p, int, v) Ensure data_at(p, int, v+1) */
/*@ With v Require v+1 <= 2147483647 && data_at(p, int, v) Ensure data_at(p, int, v+1) */
{
  *p = *p+1;
}
