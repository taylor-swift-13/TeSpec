#include "verification_stdlib.h"
void incr(unsigned int *p)
/*@ Require emp Ensure emp */
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
