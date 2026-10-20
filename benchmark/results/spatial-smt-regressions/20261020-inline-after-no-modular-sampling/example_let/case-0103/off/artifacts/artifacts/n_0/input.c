#include "verification_stdlib.h"
int doubled(int n)

/*@ __tespec_entry Require
      (n == (-1073741824)) && -1073741824 <= n && n <= 1073741823 && emp Ensure __return == n && emp */
/*@ Require -1073741824 <= n && n <= 1073741823 && emp Ensure __return == n && emp */
{ int a = n+1; int b = n-1; return a+b; }
