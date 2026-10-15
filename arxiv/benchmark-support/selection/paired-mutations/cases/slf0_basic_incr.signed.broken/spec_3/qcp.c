#include "verification_stdlib.h"
void incr(int *p)
/*@ With old Require old < 2147483647 && data_at(p,int,old) Ensure emp */
{ int n = *p; int m = n+1; *p = m; }
