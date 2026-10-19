#include "verification_stdlib.h"
int read(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (-2147483648)) && data_at(p,int,old) Ensure __return == 0 && data_at(p,int,old) */
/*@ With old Require data_at(p,int,old) Ensure __return == 0 && data_at(p,int,old) */
{ return *p; }
