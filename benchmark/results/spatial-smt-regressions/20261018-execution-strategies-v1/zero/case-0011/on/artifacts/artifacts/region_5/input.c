#include "verification_stdlib.h"

void zero (int *p)

/*@ __tespec_entry Require
      (p == (4116)) && undef_data_at(p, int) Ensure exists v, data_at(p, int, v) */
/*@ Require undef_data_at(p, int) Ensure exists v, data_at(p, int, v) */
{
  *p = 0;
}
