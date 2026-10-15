#include "verification_stdlib.h"
#include "queue_guarded_def.h"
/*@ include strategies "queue_guarded.strategies" */
void push_induction(struct int_queueCell* front, struct int_queueCell* p)

/*@ __tespec_entry With v y (l: list Z) Require
      (front == (12288)) && (p == (12288)) && (l == (nil)) && (v == (7)) && (y == (16384)) && p != 0 && front != y && y != 0 && CNQueueAux(front,p,l) * data_at(&p->first,int,v) * data_at(&p->next,struct int_queueCell*,y) Ensure CNQueueAux(front,y,app(l,cons(v,nil))) */
/*@ With v y (l: list Z) Require p != 0 && front != y && y != 0 && CNQueueAux(front,p,l) * data_at(&p->first,int,v) * data_at(&p->next,struct int_queueCell*,y) Ensure CNQueueAux(front,y,app(l,cons(v,nil))) */
{
    if (front == p) {
        return;
    } else {
        push_induction(front->next, p);
        return;
    }
}
