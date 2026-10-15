#include "verification_stdlib.h"
#include "dll_def.h"
struct node_and_int *remove(struct node *n)

/*@ __tespec_entry With h p q (ll: list Z) (lr: list Z) Require
      (n == (4096)) && (h == (7)) && (ll == (cons(2, nil))) && (lr == (cons(3, nil))) && (p == (8192)) && (q == (12288)) && (n != 0 && data_at(&n->data,int,h) * data_at(&n->prev,struct node*,p) * data_at(&n->next,struct node*,q) * DLLLeft(p,n,ll) * DLLRight(q,n,lr)) Ensure exists t v, data_at(&__return->node,struct node*,t) * data_at(&__return->data,int,h) * ((p == 0 && q == 0 && t == 0 && Dll(t,nil,0,nil)) || (q != 0 && t == q && Dll(t,ll,v,dll_tail(lr))) || (q == 0 && p != 0 && t == p && Dll(t,dll_tail(ll),v,lr))) */
/*@ With h p q (ll: list Z) (lr: list Z) Require (n != 0 && data_at(&n->data,int,h) * data_at(&n->prev,struct node*,p) * data_at(&n->next,struct node*,q) * DLLLeft(p,n,ll) * DLLRight(q,n,lr)) Ensure exists t v, data_at(&__return->node,struct node*,t) * data_at(&__return->data,int,h) * ((p == 0 && q == 0 && t == 0 && Dll(t,nil,0,nil)) || (q != 0 && t == q && Dll(t,ll,v,dll_tail(lr))) || (q == 0 && p != 0 && t == p && Dll(t,dll_tail(ll),v,lr))) */
{
    struct node *temp = 0;
    if (n->prev != 0) {
        n->prev->next = n->next;
        temp = n->prev;
    }
    if (n->next != 0) {
        n->next->prev = n->prev;
        temp = n->next;
    }
    struct node_and_int *pair = malloc_node_and_int();
    pair->node = temp;
    pair->data = n->data;
    free_node(n);
    return pair;
}
