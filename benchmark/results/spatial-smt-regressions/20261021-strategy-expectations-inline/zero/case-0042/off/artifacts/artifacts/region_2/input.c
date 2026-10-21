#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry With old Require
      (p == (4104)) && (old == (0)) && data_at(p,int,old) Ensure data_at(p,int,old) */
/*@ With old Require data_at(p,int,old) Ensure data_at(p,int,old) */
{ *p = 0; }
