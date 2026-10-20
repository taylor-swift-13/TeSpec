#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (-2147483648)) && data_at(p,int,old) Ensure data_at(p,int,old) */
/*@ With old Require data_at(p,int,old) Ensure data_at(p,int,old) */
{ *p = 0; }
