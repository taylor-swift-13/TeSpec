#include "verification_stdlib.h"
int add(int x, int y)

/*@ __tespec_entry Require
      (x == (2147483647)) && (y == (0)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ return x+y; }
