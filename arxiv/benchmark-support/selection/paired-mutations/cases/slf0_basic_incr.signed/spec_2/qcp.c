#include "verification_stdlib.h"
void incr(int *p)
/*@ Require emp Ensure emp */
{ int n = *p; int m = n+1; *p = m; }
