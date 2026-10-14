#include "verification_stdlib.h"
unsigned int quadruple (unsigned int n)
/*@ Require 4 * n <= 4294967295 && emp Ensure __return == 4 * n + 1 && emp */
{
  unsigned int m = n + n;
  return m + m;
}
