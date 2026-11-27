From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_free_list -----*)

Definition IntList_free_list_safety_wit_1 :=
  ((( &( "xs_spec_447" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  TT && emp 
.

Definition IntList_free_list_safety_wit_2 :=
forall (PreH1 : False),
  ((( &( "xs_spec_447" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (2) ((cons ((-1)) ((@nil Z))))) )
|--
  “ False ”
.

Definition IntList_free_list_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  TT && emp 
|--
  TT && emp 
.

Definition IntList_free_list_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |->_)
.

Definition IntList_free_list_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (xs_pre = 8192)) (PreH4 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z) (y_2: Z),
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_free_list_partial_solve_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (y_2: Z) (PreH1 : (y_2 = 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y <> 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z))))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
|--
  “ (y_2 = 0) ”
  &&  “ (y_2 = 0) ”
  &&  “ (y <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll y (cons ((-1)) ((@nil Z))) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 2)
.

Definition IntList_free_list_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (2) ((cons ((-1)) ((@nil Z)))))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_free_list_safety_wit_1 : IntList_free_list_safety_wit_1.
Axiom proof_of_IntList_free_list_safety_wit_2 : IntList_free_list_safety_wit_2.
Axiom proof_of_IntList_free_list_return_wit_1 : IntList_free_list_return_wit_1.
Axiom proof_of_IntList_free_list_partial_solve_wit_1 : IntList_free_list_partial_solve_wit_1.
Axiom proof_of_IntList_free_list_partial_solve_wit_2 : IntList_free_list_partial_solve_wit_2.
Axiom proof_of_IntList_free_list_partial_solve_wit_3 : IntList_free_list_partial_solve_wit_3.
Axiom proof_of_IntList_free_list_precondition_wit_1 : IntList_free_list_precondition_wit_1.

End VC_Correct.
