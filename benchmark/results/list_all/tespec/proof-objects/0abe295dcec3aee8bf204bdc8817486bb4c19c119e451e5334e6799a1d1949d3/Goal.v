From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_rev_aux -----*)

Definition IntList_rev_aux_safety_wit_1 :=
  ((( &( "xs_spec_464" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_462" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_rev_aux_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_464" ) )) # Ptr  |-> 0)
  **  ((( &( "ys_spec_462" ) )) # Ptr  |-> 16384)
  **  (sll 0 (@nil Z) )
  **  (sll 16384 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_rev_aux_return_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (retval: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (@nil Z))) (PreH7 : (b___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (sll retval (app ((rev ((@nil Z)))) ((cons (1) ((@nil Z))))) )
|--
  (sll retval (app ((rev (b___tespec_entry))) (a___tespec_entry)) )
.

Definition IntList_rev_aux_partial_solve_wit_1 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre <> 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (ys_pre = 16384)) (PreH6 : (a___tespec_entry = (@nil Z))) (PreH7 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> xs_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll ys_pre (cons (1) ((@nil Z))) )
  **  (sll y (@nil Z) )
.

Definition IntList_rev_aux_partial_solve_wit_2 :=
forall (b___tespec_entry: (@list Z)) (a___tespec_entry: (@list Z)) (xs_pre: Z) (ys_pre: Z) (PreH1 : (ys_pre <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (ys_pre = 16384)) (PreH4 : (a___tespec_entry = (@nil Z))) (PreH5 : (b___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (ys_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (ys_pre + 0)) # Int  |-> 1)
.

Definition IntList_rev_aux_precondition_wit_1 :=
exists (b___tespec_entry: (@list Z)),
exists (a___tespec_entry: (@list Z)),
exists (xs_pre: Z),
exists (ys_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (ys_pre = 16384) ”
  &&  “ (a___tespec_entry = (@nil Z)) ”
  &&  “ (b___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre a___tespec_entry )
  **  (sll ys_pre b___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_rev_aux_safety_wit_1 : IntList_rev_aux_safety_wit_1.
Axiom proof_of_IntList_rev_aux_safety_wit_2 : IntList_rev_aux_safety_wit_2.
Axiom proof_of_IntList_rev_aux_return_wit_1 : IntList_rev_aux_return_wit_1.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_1 : IntList_rev_aux_partial_solve_wit_1.
Axiom proof_of_IntList_rev_aux_partial_solve_wit_2 : IntList_rev_aux_partial_solve_wit_2.
Axiom proof_of_IntList_rev_aux_precondition_wit_1 : IntList_rev_aux_precondition_wit_1.

End VC_Correct.
