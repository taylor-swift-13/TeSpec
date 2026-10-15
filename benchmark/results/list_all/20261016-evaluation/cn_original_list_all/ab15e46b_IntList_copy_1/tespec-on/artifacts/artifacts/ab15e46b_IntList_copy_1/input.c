#include "verification_stdlib.h"
#include "sll_def.h"


struct list *mallocIntList()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->data), int) *
    undef_data_at(&(__return->next), struct list *) */;
void freeIntList(struct list *p)
/*@ Require undef_data_at(&(p->data), int) *
            undef_data_at(&(p->next), struct list *) Ensure emp */;


struct list* IntList_nil()
/*@ Require emp Ensure sll(__return, nil) */
{
  return 0;
}

struct list* IntList_cons(int h, struct list* t)
/*@ With h0 (l: list Z) Require h == h0 && sll(t,l) Ensure sll(__return,cons(h0,l)) */
{
  struct list *p = mallocIntList();
  p->data = h;
  p->next = t;
  return p;
}

struct list* IntList_copy (struct list *xs)

/*@ __tespec_entry With (l: list Z) Require
      (xs == (8192)) && (l == (cons(1, nil))) && sll(xs,l) Ensure sll(xs,l) * sll(__return,l) */
/*@ With (l: list Z) Require sll(xs,l) Ensure sll(xs,l) * sll(__return,l) */
{
  if (xs == 0) {
    return IntList_nil();
  } else {
    struct list *new_tail = IntList_copy(xs->next);
    return IntList_cons(xs->data, new_tail);
  }
}

void IntList_free_list(struct list* xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure emp */
{
  if (xs == 0) {
  } else {
    IntList_free_list(xs->next);
    freeIntList(xs);
  }
}

unsigned int IntList_length (struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure __return == Zlength(l) % 4294967296 && sll(xs,l) */
{
  if (xs == 0) {
    return 0;
  } else {
    return 1 + IntList_length (xs->next);
  }
}

struct list* IntList_rev_aux(struct list* xs, struct list* ys)
/*@ With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(__return,app(rev(b),a)) */
{
  if (ys == 0) {
    return xs;
  } else {
    struct list *tmp = ys->next;
    ys->next = xs;
    return IntList_rev_aux(ys, tmp);
  }
}

struct list* IntList_rev(struct list* xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure sll(__return,rev(l)) */
{
  return IntList_rev_aux (0, xs);
}

struct list* IntList_append(struct list* xs, struct list* ys)
/*@ With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(__return,app(a,b)) */
{
  if (xs == 0) {
    return ys;
  } else {
    struct list *new_tail = IntList_append(xs->next, ys);
    xs->next = new_tail;
    return xs;
  }
}

struct list* IntList_append2 (struct list *xs, struct list *ys)
/*@ With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(xs,a) * sll(ys,b) * sll(__return,app(a,b)) */
{
  if (xs == 0) {
    return IntList_copy(ys);
  } else {
    struct list *new_tail = IntList_append2(xs->next, ys);
    return IntList_cons(xs->data, new_tail);
  }
}
