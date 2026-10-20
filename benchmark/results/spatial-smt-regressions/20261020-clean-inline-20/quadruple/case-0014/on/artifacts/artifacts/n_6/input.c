#include "verification_stdlib.h"

int quadruple (int n)

/*@ __tespec_entry Require
      (n == (536870911)) && -2147483648 <= 4*n && 4*n <= 2147483647 && emp Ensure __return == 4*n && emp */
/*@ Require -2147483648 <= 4*n && 4*n <= 2147483647 && emp Ensure __return == 4*n && emp */
{
  int m = n + n;
  return m + m;
}
