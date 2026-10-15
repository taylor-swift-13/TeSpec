#include "verification_stdlib.h"
void zero(int *p)
/*@ Require undef_data_at(p,int) Ensure data_at(p,int,0) */
{ *p = 0; }
