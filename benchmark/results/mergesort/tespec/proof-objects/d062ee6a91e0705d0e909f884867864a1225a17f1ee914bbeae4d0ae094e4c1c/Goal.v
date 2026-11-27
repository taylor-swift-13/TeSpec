From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_merge -----*)

Definition IntList_merge_safety_wit_1 :=
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_merge_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_498" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_496" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_merge_return_wit_1 :=
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre = 16384)) (PreH5 : (l___tespec_entry = (@nil Z))) (PreH6 : (r___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )
|--
  (sll ys_pre (cn_merge (l___tespec_entry) (r___tespec_entry)) )
) \/
(
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (l___tespec_entry = (@nil Z))) (PreH7 : (r___tespec_entry = (cons (1) ((@nil Z))))),
  TT && emp 
|--
  “ (r___tespec_entry = (cn_merge (l___tespec_entry) (r___tespec_entry))) ”
  &&  emp
).

Definition IntList_merge_return_wit_1_split_goal_1 :=
forall (r___tespec_entry: (@list Z)) (l___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (l___tespec_entry = (@nil Z))) (PreH7 : (r___tespec_entry = (cons (1) ((@nil Z))))),
  (r___tespec_entry = (cn_merge (l___tespec_entry) (r___tespec_entry)))
.

Definition IntList_merge_precondition_wit_1 :=
exists (r___tespec_entry: (@list Z)),
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (r___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )
  **  (sll ys_pre r___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_merge_safety_wit_1 : IntList_merge_safety_wit_1.
Axiom proof_of_IntList_merge_safety_wit_2 : IntList_merge_safety_wit_2.
Axiom proof_of_IntList_merge_return_wit_1 : IntList_merge_return_wit_1.
Axiom proof_of_IntList_merge_precondition_wit_1 : IntList_merge_precondition_wit_1.

End VC_Correct.
