#include "verification_stdlib.h"
int quadruple(int n)

/*@ __tespec_entry Require
      (n == (1)) && -536870912 <= n && n <= 536870911 && emp Ensure __return == 4*n && emp */
/*@ Require -536870912 <= n && n <= 536870911 && emp Ensure __return == 4*n && emp */
{ return n; }
