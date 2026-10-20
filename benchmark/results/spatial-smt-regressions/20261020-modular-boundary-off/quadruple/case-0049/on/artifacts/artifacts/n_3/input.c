#include "verification_stdlib.h"
unsigned int quadruple(unsigned int n)

/*@ __tespec_entry Require
      (n == (1073741824)) && 0 <= n && n <= 4294967295 && emp Ensure __return == 0 && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == 0 && emp */
{ unsigned int m = n+n; return m+m; }
