#include "verification_stdlib.h"
#include "sll_def.h"
unsigned int length (struct list *l)
/*@ With (xs: list Z) Require Zlength(xs) < 4294967295 && sll(l,xs) Ensure __return == Zlength(xs) + 1 && sll(l,xs) */
{
  if (l == 0) {

    

    return 0;
  } else {

    

    return 1 + length(l->next);
  }
}
