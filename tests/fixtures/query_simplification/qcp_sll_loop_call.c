#include "sll_def.h"
int read_data(struct list *p) { return p->data; }
int sample(struct list *p)
/*@ With (xs : list Z) Require sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
{
    int total = 0;
    struct list *cur = p;
    while (cur != 0) { total += read_data(cur); cur = cur->next; }
    return total;
}
