#include "verification_stdlib.h"

void incr (int *p)
/*@ With v Require v+1 <= 2147483647 && data_at(p, int, v) Ensure data_at(p, int, v+1) */
{
  *p = *p+1;
}
