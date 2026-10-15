#include "verification_stdlib.h"
void inplace_double(int *p)
/*@ With old Require -1073741824 <= old && old <= 1073741823 && data_at(p,int,old) Ensure data_at(p,int,2*old) */
{ *p = 0; }
