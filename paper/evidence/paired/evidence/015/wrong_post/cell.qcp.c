#include "verification_stdlib.h"
struct list { int data; struct list *next; };
/*@ Extern Coq (sll : Z -> list Z -> Assertion)
               (sllseg : Z -> Z -> list Z -> Assertion)
               (sllbseg : Z -> Z -> list Z -> Assertion) */
/*@ Import Coq Require Import SimpleC.EE.QCP_demos_human.sll_lib */
/*@ include strategies "QCP_demos_human/sll.strategies" */
int sample(struct list *p)
/*@ With (xs : list Z)
    Require Zlength(xs) <= 100 && sll(p, xs)
    Ensure __return == Zlength(xs) + 1 && sll(p@pre, xs) */
{ if (p == 0) { return 0; } return 1 + sample(p->next); }
int main(void)
/*@ Require emp Ensure __return == 0 */
{ struct list b = {2, 0}; struct list a = {1, &b}; sample(&a); return 0; }
