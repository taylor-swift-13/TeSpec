#include "verification_stdlib.h"
int read(int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (7)) && data_at(p,int,old) Ensure __return == old && emp */
/*@ With old Require data_at(p,int,old) Ensure __return == old && emp */
{ return *p; }
