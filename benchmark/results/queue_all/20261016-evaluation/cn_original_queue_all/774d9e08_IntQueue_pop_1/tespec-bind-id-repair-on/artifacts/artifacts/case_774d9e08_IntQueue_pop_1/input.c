#include "verification_stdlib.h"
#include "sll_def.h"


struct int_queue { struct list *front; struct list *back; };
struct int_queue *mallocIntQueue()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->front),struct list *) *
    undef_data_at(&(__return->back),struct list *) */;
struct list *mallocIntQueueCell()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->data),int) *
    undef_data_at(&(__return->next),struct list *) */;
void freeIntQueueCell(struct list *p)
/*@ Require undef_data_at(&(p->data),int) *
            undef_data_at(&(p->next),struct list *) Ensure emp */;
void push_induction(struct list* front, struct list* p)
/*@ With x n (l: list Z) Require p != 0 && sllseg(front,p,l) * data_at(&p->data,int,x) * data_at(&p->next,struct list*,n) Ensure sllseg(front,n,app(l,cons(x,nil))) */
{
    if (front == p) {
        return;
    } else {
        push_induction(front->next, p);
        return;
    }
}

struct int_queue* IntQueue_empty()
/*@ Require emp Ensure (
  (data_at(field_addr(__return,int_queue,front),struct list *,0) *
   data_at(field_addr(__return,int_queue,back),struct list *,0) && (nil) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (nil) == app(pre,cons(last,nil)) &&
   data_at(field_addr(__return,int_queue,front),struct list *,f) *
   data_at(field_addr(__return,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) */
{
  struct int_queue *p = mallocIntQueue();
  p->front = 0;
  p->back = 0;
  return p;
}

int IntQueue_pop (struct int_queue *q)

/*@ __tespec_entry With x0 (l: list Z) Require
      (q == (4096)) && (l == (cons(-1, nil))) && (x0 == (2)) && (
  (exists h, l == (nil: list Z) && h != 0 &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,h) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,0)) ||
  (exists h t b last (pre: list Z), h != 0 && t != 0 && b != 0 && l == app(pre,cons(last,nil)) &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,b) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,t) *
   sllseg(t,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) Ensure __return == x0 && (
  (data_at(field_addr(q,int_queue,front),struct list *,0) *
   data_at(field_addr(q,int_queue,back),struct list *,0) && (l) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (l) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct list *,f) *
   data_at(field_addr(q,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) */
/*@ With x0 (l: list Z) Require (
  (exists h, l == (nil: list Z) && h != 0 &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,h) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,0)) ||
  (exists h t b last (pre: list Z), h != 0 && t != 0 && b != 0 && l == app(pre,cons(last,nil)) &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,b) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,t) *
   sllseg(t,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) Ensure __return == x0 && (
  (data_at(field_addr(q,int_queue,front),struct list *,0) *
   data_at(field_addr(q,int_queue,back),struct list *,0) && (l) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (l) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct list *,f) *
   data_at(field_addr(q,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) */
{
  struct list* h = q->front;
  int x = h->data;
  q->front = h->next;
  freeIntQueueCell(h);
  if (!q->front) q->back = 0;
  return x;
}

void IntQueue_push_induction (int x, struct int_queue *q)
/*@ With x0 (l: list Z) Require x == x0 && (
  (data_at(field_addr(q,int_queue,front),struct list *,0) *
   data_at(field_addr(q,int_queue,back),struct list *,0) && (l) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (l) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct list *,f) *
   data_at(field_addr(q,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) Ensure (
  (data_at(field_addr(q,int_queue,front),struct list *,0) *
   data_at(field_addr(q,int_queue,back),struct list *,0) && (app(l,cons(x0,nil))) == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && (app(l,cons(x0,nil))) == app(pre,cons(last,nil)) &&
   data_at(field_addr(q,int_queue,front),struct list *,f) *
   data_at(field_addr(q,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0))) */
{
  struct list *c = mallocIntQueueCell();
  c->data = x;
  c->next = 0;
  if (q->back == 0) {
    q->front = c;
    q->back = c;
    return;
  } else {
    struct list *oldback = q->back;
    q->back->next = c;
    q->back = c;
    push_induction(q->front, oldback);
    return;
  }
}
