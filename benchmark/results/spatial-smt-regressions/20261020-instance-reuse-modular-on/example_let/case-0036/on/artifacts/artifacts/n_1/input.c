#include "verification_stdlib.h"
int doubled(int n)

/*@ __tespec_entry Require
      (n == (-715827883)) && -1073741824 <= n && n <= 1073741823 && emp Ensure __return == 2*n+1 && emp */
/*@ Require -1073741824 <= n && n <= 1073741823 && emp Ensure __return == 2*n+1 && emp */
{ int a = n+1; int b = n-1; return a+b; }
