#include "verification_stdlib.h"
int quadruple(int n)

/*@ __tespec_entry Require
      (n == (1)) && -536870912 <= n && n <= 536870911 && emp Ensure __return == 0 && emp */
/*@ Require -536870912 <= n && n <= 536870911 && emp Ensure __return == 0 && emp */
{ int m = n+n; return m+m; }
