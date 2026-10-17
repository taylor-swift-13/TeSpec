#include "verification_stdlib.h"
void incr(unsigned int *p)

/*@ __tespec_entry Require
      (p == (8192)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ unsigned int n = *p; unsigned int m = n+1; *p = m; }
