#include "verification_stdlib.h"

int foo (int x)

/*@ __tespec_entry Require
      (x == (-2147483648)) && emp Ensure __return == 1 && emp */
/*@ Require emp Ensure __return == 1 && emp */
{
  return 1;
}
