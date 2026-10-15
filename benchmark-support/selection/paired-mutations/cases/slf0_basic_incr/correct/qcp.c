#include "verification_stdlib.h"
void incr(unsigned int *p)
/*@ With old Require 0 <= old && old <= 4294967295 && data_at(p,unsigned int,old) Ensure data_at(p,unsigned int,(old+1) % 4294967296) */
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
