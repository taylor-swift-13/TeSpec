#include "verification_stdlib.h"
void incr(unsigned int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (2147483648)) && 0 <= old && old <= 4294967295 && data_at(p,unsigned int,old) Ensure data_at(p,unsigned int,old) */
/*@ With old Require 0 <= old && old <= 4294967295 && data_at(p,unsigned int,old) Ensure data_at(p,unsigned int,old) */
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
