#include "verification_stdlib.h"
int add(int x, int y)

/*@ __tespec_entry Require
      (x == (1)) && (y == (1)) && -2147483648 <= x+y && x+y <= 2147483647 && emp Ensure __return == x+y && emp */
/*@ Require -2147483648 <= x+y && x+y <= 2147483647 && emp Ensure __return == x+y && emp */
{ return y; }
