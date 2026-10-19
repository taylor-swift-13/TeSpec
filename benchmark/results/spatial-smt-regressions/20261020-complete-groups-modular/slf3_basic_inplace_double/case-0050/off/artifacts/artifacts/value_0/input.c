#include "verification_stdlib.h"
void inplace_double(int *p)

/*@ __tespec_entry Require
      (p == (4096)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ int n = *p; int m = n+n; *p = m; }
