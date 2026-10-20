#include "verification_stdlib.h"
void zero(int *p)

/*@ __tespec_entry Require
      (p == (4100)) && emp Ensure emp */
/*@ Require emp Ensure emp */
{ *p = 0; }
