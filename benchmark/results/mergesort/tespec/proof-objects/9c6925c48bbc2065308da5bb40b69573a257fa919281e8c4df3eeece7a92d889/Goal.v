From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_mergesort -----*)

Definition IntList_mergesort_safety_wit_1 :=
  ((( &( "xs_spec_512" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_mergesort_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_512" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_mergesort_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  (sll xs_pre (cn_mergesort (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  TT && emp 
|--
  “ ((cn_mergesort (l___tespec_entry)) = (@nil Z)) ”
  &&  emp
).

Definition IntList_mergesort_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  ((cn_mergesort (l___tespec_entry)) = (@nil Z))
.

Definition IntList_mergesort_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_mergesort_safety_wit_1 : IntList_mergesort_safety_wit_1.
Axiom proof_of_IntList_mergesort_safety_wit_2 : IntList_mergesort_safety_wit_2.
Axiom proof_of_IntList_mergesort_return_wit_1 : IntList_mergesort_return_wit_1.
Axiom proof_of_IntList_mergesort_precondition_wit_1 : IntList_mergesort_precondition_wit_1.

End VC_Correct.
