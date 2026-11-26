From SimpleC.Verification Require Import VCPrelude.
Require Import input_def.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_split -----*)

Definition IntList_split_safety_wit_1 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_split_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  “ False ”
.

Definition IntList_split_safety_wit_3 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_split_safety_wit_4 :=
  ((( &( "xs_spec_476" ) )) # Ptr  |-> 0)
  **  (sll 0 (@nil Z) )
|--
  TT && emp 
.

Definition IntList_split_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (record_return: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> 0)
|--
  EX (retval_snd: Z) (retval_fst: Z),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |-> retval_fst)
  **  (sll retval_fst (cn_split_fst (l___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |-> retval_snd)
  **  (sll retval_snd (cn_split_snd (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  TT && emp 
|--
  “ ((cn_split_snd (l___tespec_entry)) = (@nil Z)) ”
  &&  “ ((cn_split_fst (l___tespec_entry)) = (@nil Z)) ”
  &&  emp
).

Definition IntList_split_return_wit_1_split_goal_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  ((cn_split_snd (l___tespec_entry)) = (@nil Z))
.

Definition IntList_split_return_wit_1_split_goal_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  ((cn_split_fst (l___tespec_entry)) = (@nil Z))
.

Definition IntList_split_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (l___tespec_entry = (@nil Z))),
  (UndefStructPredint_list_pair record_return_2 )
  **  (UndefStructPredint_list_pair record_return )
  **  (StructPredint_list_pair ( &( "r_spec_491" ) ) (make_record_int_list_pair (0) (0)) )
  **  (sll xs_pre l___tespec_entry )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
.

Definition IntList_split_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (record_return: Z) (record_return_2: Z) (PreH1 : (xs_pre = 0)) (PreH2 : (xs_pre = 0)) (PreH3 : (xs_pre = 0)) (PreH4 : (l___tespec_entry = (@nil Z))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
  **  (UndefStructPredint_list_pair record_return )
|--
  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (record_return_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return + 0)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (record_return_2 + 0)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (( &( "r_spec_491" ) ) + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (( &( "r_spec_491" ) ) + 0)) # Ptr  |-> 0)
.

Definition IntList_split_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre = 0) ”
  &&  “ (l___tespec_entry = (@nil Z)) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_split_safety_wit_1 : IntList_split_safety_wit_1.
Axiom proof_of_IntList_split_safety_wit_2 : IntList_split_safety_wit_2.
Axiom proof_of_IntList_split_safety_wit_3 : IntList_split_safety_wit_3.
Axiom proof_of_IntList_split_safety_wit_4 : IntList_split_safety_wit_4.
Axiom proof_of_IntList_split_return_wit_1 : IntList_split_return_wit_1.
Axiom proof_of_IntList_split_partial_solve_wit_1 : IntList_split_partial_solve_wit_1.
Axiom proof_of_IntList_split_partial_solve_wit_2 : IntList_split_partial_solve_wit_2.
Axiom proof_of_IntList_split_precondition_wit_1 : IntList_split_precondition_wit_1.

End VC_Correct.
