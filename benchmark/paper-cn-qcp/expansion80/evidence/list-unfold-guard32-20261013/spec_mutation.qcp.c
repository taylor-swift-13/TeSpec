#include "verification_stdlib.h"
#include "sll_layout32_def.h"
unsigned int length (struct list *l)
/*@ With (xs: list Z) Require Zlength(xs) < 4294967295 && sll32(l,xs) Ensure __return == Zlength(xs) + 1 && sll32(l,xs) */
{
  if (l == 0) {

    

    return 0;
  } else {

    

    return 1 + length(l->next);
  }
}
