From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_74fb3d745f6d13fbc8497186.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_free_list -----*)

Definition IntList_free_list_safety_wit_1 :=
  ((( &( "xs_spec_447" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_free_list_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_447" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_free_list_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  TT && emp 
.

Definition IntList_free_list_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_free_list_safety_wit_1 : IntList_free_list_safety_wit_1.
Axiom proof_of_IntList_free_list_safety_wit_2 : IntList_free_list_safety_wit_2.
Axiom proof_of_IntList_free_list_return_wit_1 : IntList_free_list_return_wit_1.
Axiom proof_of_IntList_free_list_precondition_wit_1 : IntList_free_list_precondition_wit_1.

End VC_Correct.
