#include "verification_stdlib.h"
unsigned int quadruple(unsigned int n)
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == (4*n) % 4294967296+1 && emp */
{ unsigned int m = n+n; return m+m; }
