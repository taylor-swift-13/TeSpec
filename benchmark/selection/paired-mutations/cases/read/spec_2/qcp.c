#include "verification_stdlib.h"
int read(int *p)
/*@ Require emp Ensure emp */
{ return *p; }
