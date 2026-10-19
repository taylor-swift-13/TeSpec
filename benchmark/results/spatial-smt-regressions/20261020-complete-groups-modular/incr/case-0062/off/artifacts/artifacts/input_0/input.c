#include "verification_stdlib.h"
void incr(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (-2147483648)) && old < 2147483647 && data_at(p,int,old) Ensure data_at(p,int,old+1) */
/*@ With old Require old < 2147483647 && data_at(p,int,old) Ensure data_at(p,int,old+1) */
{ *p = 0; }
