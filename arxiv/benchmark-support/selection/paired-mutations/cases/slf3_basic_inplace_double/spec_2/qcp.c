#include "verification_stdlib.h"
void inplace_double(int *p)
/*@ Require emp Ensure emp */
{ int n = *p; int m = n+n; *p = m; }
