#include "sll_def.h"
int sum_nodes(struct list *p)
{
    if (!p) return 0;
    return p->data + sum_nodes(p->next);
}
int sample(struct list *p)
/*@ With (xs : list Z) Require sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
{ return sum_nodes(p); }
