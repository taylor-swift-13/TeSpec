From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_17cfb40defe94e3d4b7fa3ed.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_copy -----*)

Definition IntList_copy_safety_wit_1 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_669" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_448" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_2 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_669" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_448" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "xs_spec_669" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_448" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_copy_safety_wit_4 :=
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_5 :=
forall (PreH1 : False),
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_copy_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (y = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval_2)) (PreH10 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (cons (1) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_copy_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll y (@nil Z) )
  **  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (y = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre l___tespec_entry )
  **  (sll retval l___tespec_entry )
.

Definition IntList_copy_partial_solve_wit_1_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_448" ) )) # Ptr  |-> 0)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
|--
  “ (1 = 1) ”
.

Definition IntList_copy_partial_solve_wit_1_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (1 = 1) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll 0 (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_partial_solve_wit_1 := IntList_copy_partial_solve_wit_1_pure -> IntList_copy_partial_solve_wit_1_aux.

Definition IntList_copy_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_partial_solve_wit_4 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (xs_pre <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
|--
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
.

Definition IntList_copy_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_copy_safety_wit_1 : IntList_copy_safety_wit_1.
Axiom proof_of_IntList_copy_safety_wit_2 : IntList_copy_safety_wit_2.
Axiom proof_of_IntList_copy_safety_wit_3 : IntList_copy_safety_wit_3.
Axiom proof_of_IntList_copy_safety_wit_4 : IntList_copy_safety_wit_4.
Axiom proof_of_IntList_copy_safety_wit_5 : IntList_copy_safety_wit_5.
Axiom proof_of_IntList_copy_entail_wit_1 : IntList_copy_entail_wit_1.
Axiom proof_of_IntList_copy_entail_wit_2 : IntList_copy_entail_wit_2.
Axiom proof_of_IntList_copy_entail_wit_3 : IntList_copy_entail_wit_3.
Axiom proof_of_IntList_copy_return_wit_1 : IntList_copy_return_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_1_pure : IntList_copy_partial_solve_wit_1_pure.
Axiom proof_of_IntList_copy_partial_solve_wit_1 : IntList_copy_partial_solve_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_2 : IntList_copy_partial_solve_wit_2.
Axiom proof_of_IntList_copy_partial_solve_wit_3 : IntList_copy_partial_solve_wit_3.
Axiom proof_of_IntList_copy_partial_solve_wit_4 : IntList_copy_partial_solve_wit_4.
Axiom proof_of_IntList_copy_partial_solve_wit_5 : IntList_copy_partial_solve_wit_5.
Axiom proof_of_IntList_copy_precondition_wit_1 : IntList_copy_precondition_wit_1.

End VC_Correct.
