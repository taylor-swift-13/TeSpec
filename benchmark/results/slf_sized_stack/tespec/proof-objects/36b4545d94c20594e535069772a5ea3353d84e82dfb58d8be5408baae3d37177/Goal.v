From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length -----*)

Definition IntList_length_safety_wit_1 :=
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_2 :=
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_length_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  “ (0 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Axiom proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Axiom proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_precondition_wit_1 : IntList_length_precondition_wit_1.

End VC_Correct.
