#include "verification_stdlib.h"
int doubled(int n)
/*@ Require -1073741824 <= n && n <= 1073741823 && emp Ensure __return == 2*n && emp */
{ return n+n+n; }
