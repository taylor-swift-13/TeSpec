#include "verification_stdlib.h"
unsigned int example_let(unsigned int n)
/*@ Require 0 <= n && n <= 4294967295 && emp Ensure __return == (2*n) % 4294967296+1 && emp */
{ unsigned int a = n+1; unsigned int b = n-1; return a+b; }
