#include "verification_stdlib.h"
int quadruple(int n)
/*@ Require -536870912 <= n && n <= 536870911 && emp Ensure __return == 4*n && emp */
{ return n; }
