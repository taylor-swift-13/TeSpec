#include "sll_def.h"

int sll_first_value(struct list *p)
/*@ With (x: Z) (xs: list Z)
    Require p != 0 && sll(p, cons(x, xs))
    Ensure __return == x + 1 && sll(p@pre, cons(x, xs))
*/
{
  return p->data;
}
