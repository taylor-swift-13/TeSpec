#include "verification_stdlib.h"
/*@ Extern Coq (mystery : Z -> Prop) */
int read(int *p) /*@ With v Require data_at(p,int,v) Ensure mystery(__return) && data_at(p,int,v) */ { return *p; }
