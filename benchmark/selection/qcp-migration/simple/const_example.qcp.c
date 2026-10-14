#include "verification_stdlib.h"

int foo (int x)
/*@ Require emp Ensure __return == 1 && emp */
{
  return 1;
}
