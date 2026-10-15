#include "verification_stdlib.h"
#include "sll_def.h"


struct list *mallocIntList()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->data), int) *
    undef_data_at(&(__return->next), struct list *) */;
void freeIntList(struct list *p)
/*@ Require undef_data_at(&(p->data), int) *
            undef_data_at(&(p->next), struct list *) Ensure emp */;
struct sized_stack { unsigned int size; struct list *data; };
struct sized_stack *malloc_sized_stack()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->size),unsigned int) *
    undef_data_at(&(__return->data),struct list *) */;


struct list* IntList_cons(int h, struct list* t)

/*@ __tespec_entry With h0 (l: list Z) Require
      (h == (-1)) && (t == (8192)) && (h0 == (-1)) && (l == (cons(-1, cons(0, cons(3, nil))))) && h == h0 && sll(t,l) Ensure sll(__return,cons(h0,l)) */
/*@ With h0 (l: list Z) Require h == h0 && sll(t,l) Ensure sll(__return,cons(h0,l)) */
{
  struct list *p = mallocIntList();
  p->data = h;
  p->next = t;
  return p;
}

struct sized_stack* create()
/*@ Require emp Ensure __return->size == 0 && __return->data == 0 */
{
  struct sized_stack *p = malloc_sized_stack();
  p->size = 0;
  p->data = 0;
  return p;
}

unsigned int sizeOf (struct sized_stack *p)
/*@ With d (l: list Z) Require p->size == Zlength(l) % 4294967296 && (p->data == d) * sll(d,l) Ensure __return == Zlength(l) % 4294967296 && p->size == Zlength(l) % 4294967296 && (p->data == d) * sll(d,l) */
{
  return p->size;
}

void push (struct sized_stack *p, int x)
/*@ With d x0 (l: list Z) Require x == x0 && p->size == Zlength(l) % 4294967296 && (p->data == d) * sll(d,l) Ensure exists d2, p->size == (Zlength(l)+1) % 4294967296 && (p->data == d2) * sll(d2,cons(x0,l)) */
{
  struct list *data = IntList_cons(x, p->data);
  p->size++;
  p->data = data;
}

int top (struct sized_stack *p)
/*@ With d h (l: list Z) Require (Zlength(l)+1) % 4294967296 > 0 && p->size == (Zlength(l)+1) % 4294967296 && (p->data == d) * sll(d,cons(h,l)) Ensure __return == h && p->size == (Zlength(l)+1) % 4294967296 && (p->data == d) * sll(d,cons(h,l)) */
{
  if (p->data != 0) {
    return (p->data)->data;
  }
  else {
    return 42;
  }
}

int pop (struct sized_stack *p)
/*@ With d h (l: list Z) Require (Zlength(l)+1) % 4294967296 > 0 && p->size == (Zlength(l)+1) % 4294967296 && (p->data == d) * sll(d,cons(h,l)) Ensure exists d2, p->size == Zlength(l) % 4294967296 && (p->data == d2) * sll(d2,l) */
{
  struct list *data = p->data;
  if (data != 0) {
    int head = data->data;
    struct list *tail = data->next;
    freeIntList(data);
    p->data = tail;
    p->size--;
    return head;
  }
  return 42;
}

struct list* IntList_nil()
/*@ Require emp Ensure sll(__return,nil) */
{
  return 0;
}

unsigned int IntList_length (struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure __return == Zlength(l)%4294967296 && sll(xs,l) */
{
  if (xs == 0) {
    return 0;
  } else {
    return 1 + IntList_length (xs->next);
  }
}
