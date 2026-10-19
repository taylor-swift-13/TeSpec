#include "verification_stdlib.h"
unsigned int quadruple(unsigned int n)

/*@ __tespec_entry Require
      (n == (0)) && 0 <= n && n <= 4294967295 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == n && emp */
{ unsigned int m = n+n; return m+m; }
