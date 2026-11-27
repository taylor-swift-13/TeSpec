From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_ec5eb2e77309e00519b44a2d.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_aux -----*)

Definition IntList_rev_aux_safety_wit_1 :=
  ((( &( "xs_spec_464" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_462" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_464" ) )) # Ptr  |-> 8192)
  **  ((( &( "ys_spec_462" ) )) # Ptr  |-> 0)
  **  (sll 8192 (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))) )
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_rev_aux_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (ys_pre = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (ys_pre = 0)) (PreH5 : (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z))))))))) (PreH6 : (b___tespec_entry = (@nil Z))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  (sll xs_pre (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
.

Definition IntList_rev_aux_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (ys_pre = 0) ”
  &&  “ (a___tespec_entry = (cons (INT_MAX) ((cons (0) ((cons ((INT_MIN)) ((@nil Z)))))))) ”
  &&  “ (b___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_safety_wit_2 : IntList_rev_aux_safety_wit_2.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_precondition_wit_1 : IntList_rev_aux_precondition_wit_1.

End VC_Correct.
