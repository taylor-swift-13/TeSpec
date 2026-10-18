#include "verification_stdlib.h"
int abs(int x)

/*@ __tespec_entry Require
      (x == (0)) && -2147483648 < x && emp Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && emp */
/*@ Require -2147483648 < x && emp Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && emp */
{ return x; }
