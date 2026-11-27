From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_append2 -----*)

Definition IntList_append2_safety_wit_1 :=
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_append2_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_500" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_498" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_append2_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (retval: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (@nil Z))) (PreH7 : (b___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (sll ys_pre b___tespec_entry )
  **  (sll retval b___tespec_entry )
|--
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
  **  (sll retval (app (a___tespec_entry) (b___tespec_entry)) )
.

Definition IntList_append2_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (ys_pre <> 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (ys_pre = 16384)) (PreH5 : (a___tespec_entry = (@nil Z))) (PreH6 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll ys_pre b___tespec_entry )
.

Definition IntList_append2_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_append2_safety_wit_1 : IntList_append2_safety_wit_1.
Axiom proof_of_IntList_append2_safety_wit_2 : IntList_append2_safety_wit_2.
Axiom proof_of_IntList_append2_return_wit_1 : IntList_append2_return_wit_1.
Axiom proof_of_IntList_append2_partial_solve_wit_1 : IntList_append2_partial_solve_wit_1.
Axiom proof_of_IntList_append2_precondition_wit_1 : IntList_append2_precondition_wit_1.

End VC_Correct.
