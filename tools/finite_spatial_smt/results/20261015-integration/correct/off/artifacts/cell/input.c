#include "verification_stdlib.h"
int read(int *p) 
/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (7)) && data_at(p,int,v) Ensure data_at(p,int,v) && __return == v */
/*@ With v Require data_at(p,int,v) Ensure data_at(p,int,v) && __return == v */ { return *p; }
