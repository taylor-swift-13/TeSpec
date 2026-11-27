From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_17cfb40defe94e3d4b7fa3ed.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_copy -----*)

Definition IntList_copy_safety_wit_1 :=
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_2 :=
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_copy_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll retval (@nil Z) )
.

Definition IntList_copy_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  (sll xs_pre l___tespec_entry )
  **  (sll 0 l___tespec_entry )
.

Definition IntList_copy_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  emp
.

Definition IntList_copy_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_copy_safety_wit_1 : IntList_copy_safety_wit_1.
Axiom proof_of_IntList_copy_safety_wit_2 : IntList_copy_safety_wit_2.
Axiom proof_of_IntList_copy_safety_wit_3 : IntList_copy_safety_wit_3.
Axiom proof_of_IntList_copy_entail_wit_1 : IntList_copy_entail_wit_1.
Axiom proof_of_IntList_copy_return_wit_1 : IntList_copy_return_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_1 : IntList_copy_partial_solve_wit_1.
Axiom proof_of_IntList_copy_precondition_wit_1 : IntList_copy_precondition_wit_1.

End VC_Correct.
