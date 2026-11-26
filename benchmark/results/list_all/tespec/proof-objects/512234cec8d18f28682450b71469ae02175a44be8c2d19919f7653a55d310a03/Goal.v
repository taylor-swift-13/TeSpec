From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length_acc -----*)

Definition IntList_length_acc_safety_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "p_spec_671" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_670" ) )) # Ptr  |-> 0)
  **  ((retval) # UInt  |-> 0)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 0)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_2 :=
forall (retval: Z) (PreH1 : False),
  ((( &( "p_spec_671" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_670" ) )) # Ptr  |-> 0)
  **  ((retval) # UInt  |-> 0)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 0)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_3 :=
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_length_acc_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (l___tespec_entry = (@nil Z))) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
|--
  “ (retval <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((0 + (Zlength ((@nil Z))) ) % ( 4294967296 ) ))
  **  (sll xs_pre (@nil Z) )
.

Definition IntList_length_acc_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (0 <= retval_2)) (PreH6 : (retval_2 <= UINT_MAX)),
  ((retval_2) # UInt  |-> 0)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  ((retval) # UInt  |-> 0)
.

Definition IntList_length_acc_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (l___tespec_entry = (@nil Z))) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  TT && emp 
|--
  “ (0 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (retval <> 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (xs_pre = 0)) (PreH5 : (l___tespec_entry = (@nil Z))) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
|--
  “ (xs_pre = 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |->_)
.

Definition IntList_length_acc_partial_solve_wit_2_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_2_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (retval <> 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 0)
  **  (sll xs_pre (@nil Z) )
.

Definition IntList_length_acc_partial_solve_wit_2 := IntList_length_acc_partial_solve_wit_2_pure -> IntList_length_acc_partial_solve_wit_2_aux.

Definition IntList_length_acc_partial_solve_wit_3_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (l___tespec_entry = (@nil Z))),
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l___tespec_entry )
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_3_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  emp
.

Definition IntList_length_acc_partial_solve_wit_3 := IntList_length_acc_partial_solve_wit_3_pure -> IntList_length_acc_partial_solve_wit_3_aux.

Definition IntList_length_acc_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (l___tespec_entry = (@nil Z))),
  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  emp
.

Definition IntList_length_acc_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_safety_wit_1 : IntList_length_acc_safety_wit_1.
Axiom proof_of_IntList_length_acc_safety_wit_2 : IntList_length_acc_safety_wit_2.
Axiom proof_of_IntList_length_acc_safety_wit_3 : IntList_length_acc_safety_wit_3.
Axiom proof_of_IntList_length_acc_entail_wit_1 : IntList_length_acc_entail_wit_1.
Axiom proof_of_IntList_length_acc_entail_wit_2 : IntList_length_acc_entail_wit_2.
Axiom proof_of_IntList_length_acc_return_wit_1 : IntList_length_acc_return_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_1 : IntList_length_acc_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2_pure : IntList_length_acc_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2 : IntList_length_acc_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3_pure : IntList_length_acc_partial_solve_wit_3_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3 : IntList_length_acc_partial_solve_wit_3.
Axiom proof_of_IntList_length_acc_partial_solve_wit_4 : IntList_length_acc_partial_solve_wit_4.
Axiom proof_of_IntList_length_acc_precondition_wit_1 : IntList_length_acc_precondition_wit_1.

End VC_Correct.
