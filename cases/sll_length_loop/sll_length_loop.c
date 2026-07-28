#include "sll_def.h"

int sll_length_loop(struct list *p)
/*@ With (l: list Z)
    Require sll(p, l) && Zlength(l) <= 2147483647
    Ensure __return == Zlength(l) && sll(p@pre, l)
*/
{
    int n = 0;
    while (p) {
        n++;
        p = p->next;
    }
    return n;
}
