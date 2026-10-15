#include "verification_stdlib.h"
int add(int x, int y)
/*@ Require emp Ensure emp */
{ return x+y; }
