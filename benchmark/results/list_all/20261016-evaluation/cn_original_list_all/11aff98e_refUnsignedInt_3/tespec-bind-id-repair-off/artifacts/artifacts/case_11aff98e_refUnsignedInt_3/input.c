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

/*@ Import Coq Require Import FulminateMerge */
/*@ Extern Coq (cn_split_fst : list Z -> list Z) (cn_split_snd : list Z -> list Z) (cn_merge : list Z -> list Z -> list Z) (cn_mergesort : list Z -> list Z) */
struct int_list_pair { struct list *fst; struct list *snd; };
unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void freeUnsignedInt(unsigned int *p)
/*@ Require undef_data_at(p,unsigned int) Ensure emp */;

struct list* IntList_rev_loop(struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure sll(__return,rev(l)) */
{
  struct list *last = 0;
  struct list *cur = xs;
  /*@ Inv exists (l1: list Z) (l2: list Z), app(rev(l2),l1) == rev(l) && sll(last,l1) * sll(cur,l2) */
  while(1)
  {
    if (cur == 0) {
      return last;
    }
    struct list *tmp = cur->next;
    cur->next = last;
    last = cur;
    cur = tmp;
  }
}

struct int_list_pair IntList_split(struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure sll(__return.fst,cn_split_fst(l)) * sll(__return.snd,cn_split_snd(l)) */
{
  if (xs == 0) {
    struct int_list_pair r = {.fst = 0, .snd = 0};
    return r;
  } else {
    struct list *cdr = xs ->next;
    if (cdr == 0) {
      struct int_list_pair r = {.fst = 0, .snd = xs};
      return r;
    } else {
      struct int_list_pair p = IntList_split(cdr->next);
      xs->next = p.fst;
      cdr->next = p.snd;
      struct int_list_pair r = {.fst = xs, .snd = cdr};
      return r;
    }
  }
}

struct list* IntList_merge(struct list *xs, struct list *ys)
/*@ With (l: list Z) (r: list Z) Require sll(xs,l) * sll(ys,r) Ensure sll(__return,cn_merge(l,r)) */
{
  if (xs == 0) {
    return ys;
  } else {
    if (ys == 0) {
      return xs;
    } else {
      if (xs->data < ys->data) {
        struct list *zs = IntList_merge(xs->next, ys);
        xs->next = zs;
        return xs;
      } else {
        struct list *zs = IntList_merge(xs, ys->next);
        ys->next = zs;
        return ys;
      }
    }
  }
}

struct list* IntList_mergesort(struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure sll(__return,cn_mergesort(l)) */
{
  if (xs == 0) {
    return xs;
  } else {
    struct list *tail = xs->next;
    if (tail == 0) {
      return xs;
    } else {
      struct int_list_pair p = IntList_split(xs);
      p.fst = IntList_mergesort(p.fst);
      p.snd = IntList_mergesort(p.snd);
      return IntList_merge(p.fst, p.snd);
    }
  }
}

unsigned int *refUnsignedInt (unsigned int v)

/*@ __tespec_entry Require
      (v == (4294967295)) && 0 <= v && v <= 4294967295 && emp Ensure data_at(__return,unsigned int,v) */
/*@ Require 0 <= v && v <= 4294967295 && emp Ensure data_at(__return,unsigned int,v) */
{
    unsigned int *res = mallocUnsignedInt();
    *res = v;
    return res;
}

void IntList_length_acc_aux (struct list *xs, unsigned int *p)
/*@ With n (l: list Z) Require 0 <= n && n <= 4294967295 && data_at(p,unsigned int,n) * sll(xs,l) Ensure data_at(p,unsigned int,(n+Zlength(l))%4294967296) * sll(xs,l) */
{
  if (xs == 0) {
  } else {
    *p = *p + 1;
    IntList_length_acc_aux (xs->next, p);
  }
}

unsigned int IntList_length_acc (struct list *xs)
/*@ With (l: list Z) Require sll(xs,l) Ensure __return == Zlength(l)%4294967296 && sll(xs,l) */
{
  unsigned int *p = refUnsignedInt(0);
  IntList_length_acc_aux(xs, p);
  unsigned int x = *p;
  freeUnsignedInt(p);
  return x;
}
