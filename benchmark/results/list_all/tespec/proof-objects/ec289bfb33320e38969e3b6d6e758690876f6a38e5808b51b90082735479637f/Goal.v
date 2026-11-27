From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_copy -----*)

Definition IntList_copy_safety_wit_1 :=
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_copy_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_437" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_copy_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval_2: Z) (retval: Z) (PreH1 : (retval_2 = 0)) (PreH2 : (y = 0)) (PreH3 : (retval_2 = 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre <> 0)) (PreH8 : (xs_pre = 8192)) (PreH9 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH10 : (0 <= retval_2)) (PreH11 : (retval_2 <= UINT_MAX)) (PreH12 : (0 <= retval)) (PreH13 : (retval <= UINT_MAX)),
  (sll retval (cons (1) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  (sll xs_pre l___tespec_entry )
  **  (sll retval l___tespec_entry )
.

Definition IntList_copy_partial_solve_wit_1_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (sll y (@nil Z) )
  **  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "new_tail_spec_448" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_437" ) )) # Ptr  |-> xs_pre)
|--
  “ (1 = 1) ”
.

Definition IntList_copy_partial_solve_wit_1_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (sll y (@nil Z) )
  **  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (1 = 1) ”
  &&  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (retval = 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  (sll retval (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_copy_partial_solve_wit_1 := IntList_copy_partial_solve_wit_1_pure -> IntList_copy_partial_solve_wit_1_aux.

Definition IntList_copy_partial_solve_wit_2 :=
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

Definition IntList_copy_partial_solve_wit_3 :=
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
Axiom proof_of_IntList_copy_return_wit_1 : IntList_copy_return_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_1_pure : IntList_copy_partial_solve_wit_1_pure.
Axiom proof_of_IntList_copy_partial_solve_wit_1 : IntList_copy_partial_solve_wit_1.
Axiom proof_of_IntList_copy_partial_solve_wit_2 : IntList_copy_partial_solve_wit_2.
Axiom proof_of_IntList_copy_partial_solve_wit_3 : IntList_copy_partial_solve_wit_3.
Axiom proof_of_IntList_copy_precondition_wit_1 : IntList_copy_precondition_wit_1.

End VC_Correct.
