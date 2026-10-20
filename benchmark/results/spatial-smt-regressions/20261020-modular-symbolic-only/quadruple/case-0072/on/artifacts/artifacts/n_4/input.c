#include "verification_stdlib.h"
int quadruple(int n)

/*@ __tespec_entry Require
      (n == (5)) && -536870912 <= n && n <= 536870911 && emp Ensure __return == n && emp */
/*@ Require -536870912 <= n && n <= 536870911 && emp Ensure __return == n && emp */
{ int m = n+n; return m+m; }
