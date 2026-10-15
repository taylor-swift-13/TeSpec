#include "verification_stdlib.h"
void zero(int *p)
/*@ With old Require data_at(p,int,old) Ensure data_at(p,int,old) */
{ *p = 0; }
