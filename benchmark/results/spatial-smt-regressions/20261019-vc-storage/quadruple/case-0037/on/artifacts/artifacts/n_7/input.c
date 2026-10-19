#include "verification_stdlib.h"
unsigned int quadruple(unsigned int n)

/*@ __tespec_entry Require
      (n == (4294967295)) && 0 <= n && n <= 4294967295 && emp Ensure __return == (4*n) % 4294967296+1 && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == (4*n) % 4294967296+1 && emp */
{ unsigned int m = n+n; return m+m; }
