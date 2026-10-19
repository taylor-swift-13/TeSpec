#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry With old Require
      (p == (4116)) && (old == (2147483647)) && data_at(p,int,old) Ensure data_at(p,int,old) */
/*@ With old Require data_at(p,int,old) Ensure data_at(p,int,old) */
{ *p = 0; }
