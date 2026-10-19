#include "sll_def.h"
int sum_nodes(struct list *p)
{
    if (!p) return 0;
    return p->data + sum_nodes(p->next);
}
int sample(struct list *p)

/*@ __tespec_entry With (xs : list Z) Require
      (p == (4096)) && (xs == (cons(1, cons(2, nil)))) && sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
/*@ With (xs : list Z) Require sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
{ return sum_nodes(p); }
