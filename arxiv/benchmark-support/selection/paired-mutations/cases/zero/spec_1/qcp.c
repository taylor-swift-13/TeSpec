#include "verification_stdlib.h"
void zero(int *p)
/*@ Require undef_data_at(p,int) Ensure data_at(p,int,1) */
{ *p = 0; }
