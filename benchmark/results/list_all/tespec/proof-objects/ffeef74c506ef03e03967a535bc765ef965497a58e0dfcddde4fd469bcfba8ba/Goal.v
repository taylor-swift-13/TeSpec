From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length_acc_aux -----*)

Definition IntList_length_acc_aux_safety_wit_1 :=
  ((( &( "xs_spec_637" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_length_acc_aux_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_637" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_635" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_length_acc_aux_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (n___tespec_entry: Z) (xs_pre: Z) (p_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (n___tespec_entry = 0)) (PreH6 : (0 <= n___tespec_entry)) (PreH7 : (n___tespec_entry <= UINT_MAX)),
  ((p_pre) # UInt  |-> n___tespec_entry)
  **  (sll xs_pre l___tespec_entry )
|--
  ((p_pre) # UInt  |-> ((n___tespec_entry + (Zlength (l___tespec_entry)) ) % ( 4294967296 ) ))
  **  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_aux_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (n___tespec_entry: Z),
exists (xs_pre: Z),
exists (p_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (n___tespec_entry = 0) ”
  &&  “ (0 <= n___tespec_entry) ”
  &&  “ (n___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> n___tespec_entry)
  **  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_aux_safety_wit_1 : IntList_length_acc_aux_safety_wit_1.
Axiom proof_of_IntList_length_acc_aux_safety_wit_2 : IntList_length_acc_aux_safety_wit_2.
Axiom proof_of_IntList_length_acc_aux_return_wit_1 : IntList_length_acc_aux_return_wit_1.
Axiom proof_of_IntList_length_acc_aux_precondition_wit_1 : IntList_length_acc_aux_precondition_wit_1.

End VC_Correct.
