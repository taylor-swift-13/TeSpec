#include "verification_stdlib.h"
int read(int *p)

/*@ __tespec_entry Require
      (p == (0)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ return *p; }
