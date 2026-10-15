#include "verification_stdlib.h"
int read(int *p)
/*@ With old Require data_at(p,int,old) Ensure __return == old && data_at(p,int,old) */
{ return -*p; }
