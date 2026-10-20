#include "verification_stdlib.h"
void incr (int *p)

/*@ __tespec_entry Require
      (p == (8192)) && undef_data_at(p,int) Ensure exists v, data_at(p,int,v) */
/*@ Require undef_data_at(p,int) Ensure exists v, data_at(p,int,v) */
{
  int n = *p;
  int m = n+1;
  *p = m;
}
