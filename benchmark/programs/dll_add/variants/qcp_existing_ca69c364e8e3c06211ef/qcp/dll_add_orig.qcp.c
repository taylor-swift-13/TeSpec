#include "verification_stdlib.h"
#include "dll_def.h"
struct node *add(int element, struct node *n)
/*@ With h p q (ll: list Z) (lr: list Z)
    Require (
      (n == 0 && ll == nil && lr == nil && emp) ||
      (n != 0 &&
       data_at(&n->data,int,h) *
       data_at(&n->prev,struct node*,p) *
       data_at(&n->next,struct node*,q) *
       DLLLeft(p,n,ll) *
       DLLRight(q,n,lr)))
    Ensure __return != 0 &&
      (exists v,
        (n == 0 && Dll(__return,nil,v,nil)) ||
        (n != 0 && Dll(__return,cons(h,ll),v,lr)))
*/
{
    struct node *new_node = malloc_node();
    new_node->data = element;
    new_node->prev = 0;
    new_node->next = 0;
    if (n == 0)
    {
        new_node->prev = 0;
        new_node->next = 0;
        return new_node;
    } else {
        new_node->next = n->next;
        new_node->prev = n;
        if (n->next !=0) {
            n->next->prev = new_node;
        }
        n->next = new_node;
        return new_node;
    }
}
