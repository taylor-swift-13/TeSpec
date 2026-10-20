#include "verification_stdlib.h"
unsigned int example_let(unsigned int n)

/*@ __tespec_entry Require
      (n == (4294967295)) && 0 <= n && n <= 4294967295 && emp Ensure __return == n && emp */
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == n && emp */
{ unsigned int a = n+1; unsigned int b = n-1; return a+b; }
