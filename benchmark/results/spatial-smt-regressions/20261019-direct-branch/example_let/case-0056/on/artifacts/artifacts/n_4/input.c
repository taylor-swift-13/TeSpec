#include "verification_stdlib.h"
unsigned int example_let(unsigned int n)

/*@ __tespec_entry Require
      (n == (2147483647)) && 0 <= n && n <= 4294967295 && emp Ensure __return == (2*n) % 4294967296 && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == (2*n) % 4294967296 && emp */
{ return 0; }
