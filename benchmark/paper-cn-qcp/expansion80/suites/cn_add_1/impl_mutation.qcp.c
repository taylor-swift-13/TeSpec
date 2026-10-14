#include "verification_stdlib.h"
int add(int x, int y)
/* --BEGIN-- */
/*@ Require x + y >= -2147483648 && x + y <= 2147483647 && emp Ensure __return == x + y && emp */
/* --END-- */
{
  return x;
}
