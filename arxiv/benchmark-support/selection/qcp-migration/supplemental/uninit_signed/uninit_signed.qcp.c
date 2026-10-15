#include "verification_stdlib.h"
void incr (int *p)
/*@ Require undef_data_at(p,int) Ensure exists v, data_at(p,int,v) */
{
  *p = *p+1;
}
