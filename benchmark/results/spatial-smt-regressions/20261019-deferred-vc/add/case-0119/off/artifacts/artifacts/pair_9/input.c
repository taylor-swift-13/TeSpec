#include "verification_stdlib.h"

int add(int x, int y)

/*@ __tespec_entry Require
      (x == (-2147483648)) && (y == (0)) && -2147483648 <= x+y && x+y <= 2147483647 && emp Ensure emp */
/*@ Require -2147483648 <= x+y && x+y <= 2147483647 && emp Ensure emp */
{
  return x+y;
}
