#include "verification_stdlib.h"

int add(int x, int y)
/*@ Require -2147483648 <= x+y && x+y <= 2147483647 && emp Ensure emp */
{
  return x+y;
}
