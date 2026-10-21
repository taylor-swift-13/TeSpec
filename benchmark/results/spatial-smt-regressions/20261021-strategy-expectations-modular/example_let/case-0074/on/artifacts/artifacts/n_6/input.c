#include "verification_stdlib.h"
int doubled(int n)

/*@ __tespec_entry Require
      (n == (715827882)) && -1073741824 <= n && n <= 1073741823 && emp Ensure __return == 2*n && emp */
/*@ Require -1073741824 <= n && n <= 1073741823 && emp Ensure __return == 2*n && emp */
{ return 0; }
