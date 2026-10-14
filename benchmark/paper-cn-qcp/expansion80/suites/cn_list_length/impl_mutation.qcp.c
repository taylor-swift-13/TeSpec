#include "verification_stdlib.h"
#include "sll_def.h"
unsigned int length (struct list *l)
/*@ With (xs: list Z) Require Zlength(xs) < 4294967295 && sll(l,xs) Ensure __return == Zlength(xs) && sll(l,xs) */
{
  if (l == 0) {

    

    return 1;
  } else {

    

    return 1 + length(l->next);
  }
}
