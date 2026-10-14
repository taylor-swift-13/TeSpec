#ifndef TESPEC_LIST_LAYOUT32_DEF_H
#define TESPEC_LIST_LAYOUT32_DEF_H
struct list {
    int data;
    struct list *next;
};
/*@ Extern Coq (sll32 : Z -> list Z -> Assertion)
               (sllseg32 : Z -> Z -> list Z -> Assertion)
               (sllbseg32 : Z -> Z -> list Z -> Assertion) */
/*@ Import Coq Require Import SimpleC.EE.QCP_demos_human.sll_layout32 */
/*@ include strategies "sll_layout32.strategies" */
#endif
