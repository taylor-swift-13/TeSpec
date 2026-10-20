#include "verification_stdlib.h"
void incr(unsigned int *p)

/*@ __tespec_entry With old Require
      (p == (4096)) && (old == (0)) && 0 <= old && old <= 4294967295 && data_at(p,unsigned int,old) Ensure data_at(p,unsigned int,(old+1) % 4294967296) */
/*@ With old Require 0 <= old && old <= 4294967295 && data_at(p,unsigned int,old) Ensure data_at(p,unsigned int,(old+1) % 4294967296) */
{ *p = 0; }
