#include "verification_stdlib.h"
void zero(int *p)
/*@ Require emp Ensure emp */
{ *p = 0; }
