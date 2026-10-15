#include "verification_stdlib.h"
#include "queue_guarded_def.h"
/*@ include strategies "queue_guarded.strategies" */
struct int_queueCell *mallocIntQueueCell()
/*@ Require emp Ensure __return != 0 && undef_data_at(&(__return->first),int) * undef_data_at(&(__return->next),struct int_queueCell *) */;
void push_induction(struct int_queueCell* front, struct int_queueCell* p)
/*@ With v y (l: list Z) Require p != 0 && front != y && y != 0 && CNQueueAux(front,p,l) * data_at(&p->first,int,v) * data_at(&p->next,struct int_queueCell*,y) Ensure CNQueueAux(front,y,app(l,cons(v,nil))) */
{
    if (front == p) {
        return;
    } else {
        push_induction(front->next, p);
        return;
    }
}

void IntQueue_push_induction (int x, struct int_queue *q)

/*@ __tespec_entry With x0 (l: list Z) Require
      (x == (-1)) && (q == (4096)) && (l == (cons(2147483647, cons(0, cons(-2147483648, nil))))) && (x0 == (-1)) && x == x0 && (
  (data_at(field_addr(q,int_queue,front),struct int_queueCell *,0) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,0) && (l) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (l) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct int_queueCell *,f) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,b) *
   CNQueueAux(f,b,pre) * data_at(field_addr(b,int_queueCell,first),int,last) *
   data_at(field_addr(b,int_queueCell,next),struct int_queueCell *,0))) Ensure (
  (data_at(field_addr(q,int_queue,front),struct int_queueCell *,0) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,0) && (app(l,cons(x0,nil))) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (app(l,cons(x0,nil))) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct int_queueCell *,f) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,b) *
   CNQueueAux(f,b,pre) * data_at(field_addr(b,int_queueCell,first),int,last) *
   data_at(field_addr(b,int_queueCell,next),struct int_queueCell *,0))) */
/*@ With x0 (l: list Z) Require x == x0 && (
  (data_at(field_addr(q,int_queue,front),struct int_queueCell *,0) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,0) && (l) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (l) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct int_queueCell *,f) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,b) *
   CNQueueAux(f,b,pre) * data_at(field_addr(b,int_queueCell,first),int,last) *
   data_at(field_addr(b,int_queueCell,next),struct int_queueCell *,0))) Ensure (
  (data_at(field_addr(q,int_queue,front),struct int_queueCell *,0) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,0) && (app(l,cons(x0,nil))) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (app(l,cons(x0,nil))) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct int_queueCell *,f) *
   data_at(field_addr(q,int_queue,back),struct int_queueCell *,b) *
   CNQueueAux(f,b,pre) * data_at(field_addr(b,int_queueCell,first),int,last) *
   data_at(field_addr(b,int_queueCell,next),struct int_queueCell *,0))) */
{
  struct int_queueCell *c = mallocIntQueueCell();
  c->first = x;
  c->next = 0;
  if (q->back == 0) {
    q->front = c;
    q->back = c;
    return;
  } else {
    struct int_queueCell *oldback = q->back;
    q->back->next = c;
    q->back = c;
    push_induction(q->front, oldback);
    return;
  }
}
