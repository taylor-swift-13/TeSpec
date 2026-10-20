#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry Require
      (p == (4112)) && undef_data_at(p,int) Ensure data_at(p,int,1) */
/*@ Require undef_data_at(p,int) Ensure data_at(p,int,1) */
{ *p = 0; }
