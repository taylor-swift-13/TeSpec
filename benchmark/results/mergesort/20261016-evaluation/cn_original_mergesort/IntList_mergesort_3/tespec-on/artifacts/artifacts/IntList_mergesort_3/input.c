#include "verification_stdlib.h"

#include "sll_def.h"

/*@ Import Coq Require Import FulminateMerge */

/*@ Extern Coq (cn_split_fst : list Z -> list Z) (cn_split_snd : list Z -> list Z) (cn_merge : list Z -> list Z -> list Z) (cn_mergesort : list Z -> list Z) */

struct int_list_pair { struct list *fst; struct list *snd; };

struct list *mallocIntList()
/*@ Require emp Ensure __return != 0 && undef_data_at(&__return->data,int) * undef_data_at(&__return->next,struct list*) */;

void freeIntList(struct list *p)
/*@ Require undef_data_at(&p->data,int) * undef_data_at(&p->next,struct list*) Ensure emp */;

struct list* IntList_nil()
/*@ Require emp Ensure sll(__return,nil) */
{
  return 0;
}

struct list* IntList_cons(int h, struct list* t)
/*@ With (l: list Z) Require sll(t,l) Ensure sll(__return,cons(h,l)) */
{
  struct list *p = mallocIntList();
  p->data = h;
  p->next = t;
  return p;
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

/*@ __tespec_entry With (l: list Z) Require
      (xs == (8192)) && (l == (cons(2147483647, cons(0, cons(-2147483648, nil))))) && sll(xs,l) Ensure sll(__return,cn_mergesort(l)) */
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
