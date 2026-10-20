#include "verification_stdlib.h"
void incr(int *p)

/*@ __tespec_entry Require
      (p == (12288)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ int n = *p; int m = n+1; *p = m; }
