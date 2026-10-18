#include "verification_stdlib.h"
int read(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (-1)) && data_at(p,int,old) Ensure __return == old && data_at(p,int,old) */
/*@ With old Require data_at(p,int,old) Ensure __return == old && data_at(p,int,old) */
{ *p = 0; return *p; }
