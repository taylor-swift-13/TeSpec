#include "verification_stdlib.h"
int abs(int x)

/*@ __tespec_entry Require
      (x == (-1)) && emp Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && emp */
/*@ Require emp Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && emp */
{ if (x >= 0) { return x; } else { return -x; } }
