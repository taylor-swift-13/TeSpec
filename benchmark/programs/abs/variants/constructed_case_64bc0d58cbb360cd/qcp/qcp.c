#include "verification_stdlib.h"
int abs(int x)
/*@ Require -2147483648 < x && emp Ensure __return == -x && emp */
{ if (x >= 0) { return x; } else { return -x; } }
