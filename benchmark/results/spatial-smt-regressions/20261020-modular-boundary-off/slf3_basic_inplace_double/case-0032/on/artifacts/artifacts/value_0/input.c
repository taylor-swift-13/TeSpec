#include "verification_stdlib.h"
void inplace_double(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (-1073741824)) && -1073741824 <= old && old <= 1073741823 && data_at(p,int,old) Ensure data_at(p,int,2*old) */
/*@ With old Require -1073741824 <= old && old <= 1073741823 && data_at(p,int,old) Ensure data_at(p,int,2*old) */
{ *p = *p + 2; }
