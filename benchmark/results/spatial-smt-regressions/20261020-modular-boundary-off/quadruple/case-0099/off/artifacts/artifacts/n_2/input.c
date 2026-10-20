#include "verification_stdlib.h"
unsigned int quadruple(unsigned int n)

/*@ __tespec_entry Require
      (n == (5)) && 0 <= n && n <= 4294967295 && emp Ensure __return == (4*n) % 4294967296 && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == (4*n) % 4294967296 && emp */
{ return 0; }
