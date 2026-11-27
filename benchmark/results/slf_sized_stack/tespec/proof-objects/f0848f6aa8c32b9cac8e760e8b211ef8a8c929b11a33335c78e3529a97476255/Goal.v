From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length -----*)

Definition IntList_length_safety_wit_1 :=
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_2 :=
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_3 :=
forall (PreH1 : False),
  ((( &( "xs_spec_552" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_length_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval = ((Zlength ((@nil Z))) % ( 4294967296 ) ))) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ ((1 + retval ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_partial_solve_wit_1 :=
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

Definition IntList_length_partial_solve_wit_2 :=
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

Definition IntList_length_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_safety_wit_1 : IntList_length_safety_wit_1.
Axiom proof_of_IntList_length_safety_wit_2 : IntList_length_safety_wit_2.
Axiom proof_of_IntList_length_safety_wit_3 : IntList_length_safety_wit_3.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Axiom proof_of_IntList_length_precondition_wit_1 : IntList_length_precondition_wit_1.

End VC_Correct.
