#include "verification_stdlib.h"
void inplace_double(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (2)) && -1073741824 <= old && old <= 1073741823 && data_at(p,int,old) Ensure data_at(p,int,old) */
/*@ With old Require -1073741824 <= old && old <= 1073741823 && data_at(p,int,old) Ensure data_at(p,int,old) */
{ int n = *p; int m = n+n; *p = m; }
