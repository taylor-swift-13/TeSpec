#include "verification_stdlib.h"
/*@ Extern Coq (mystery : Z -> Prop) */
int read(int *p) 
/*@ __tespec_entry With v Require
      (p == (4096)) && (v == (7)) && data_at(p,int,v) Ensure mystery(__return) && data_at(p,int,v) */
/*@ With v Require data_at(p,int,v) Ensure mystery(__return) && data_at(p,int,v) */ { return *p; }
