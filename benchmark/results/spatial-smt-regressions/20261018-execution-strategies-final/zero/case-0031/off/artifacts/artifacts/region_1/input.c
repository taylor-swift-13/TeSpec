#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry Require
      (p == (4100)) && undef_data_at(p,int) Ensure data_at(p,int,0) */
/*@ Require undef_data_at(p,int) Ensure data_at(p,int,0) */
{ }
