#include "sll_def.h"
int read_data(struct list *p) { return p->data; }
int sample(struct list *p)

/*@ __tespec_entry With (xs : list Z) Require
      (p == (4096)) && (xs == (cons(1, cons(2, nil)))) && sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
/*@ With (xs : list Z) Require sll(p, xs)
    Ensure __return == 3 && sll(p, xs) */
{
    int total = 0;
    struct list *cur = p;
    while (cur != 0) { total += read_data(cur); cur = cur->next; }
    return total;
}
