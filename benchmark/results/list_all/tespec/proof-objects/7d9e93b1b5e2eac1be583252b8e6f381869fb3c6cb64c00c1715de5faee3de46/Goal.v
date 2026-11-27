From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_2bd3caf24386db6c22522ec8.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length -----*)

Definition IntList_length_safety_wit_1 :=
  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_2 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_523" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_3 :=
forall (y: Z) (PreH1 : (y = 0)),
  ((( &( "xs_spec_523" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_safety_wit_4 :=
forall (PreH1 : False),
  ((( &( "xs_spec_523" ) )) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_safety_wit_5 :=
  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_safety_wit_6 :=
forall (PreH1 : False),
  ((( &( "xs_spec_454" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  “ False ”
.

Definition IntList_length_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z),
  “ (retval = 0) ”
  &&  “ (retval = ((Zlength ((@nil Z))) % ( 4294967296 ) )) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (PreH1 : (y = 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ ((1 + 0 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
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
Axiom proof_of_IntList_length_safety_wit_4 : IntList_length_safety_wit_4.
Axiom proof_of_IntList_length_safety_wit_5 : IntList_length_safety_wit_5.
Axiom proof_of_IntList_length_safety_wit_6 : IntList_length_safety_wit_6.
Axiom proof_of_IntList_length_entail_wit_1 : IntList_length_entail_wit_1.
Axiom proof_of_IntList_length_return_wit_1 : IntList_length_return_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_1 : IntList_length_partial_solve_wit_1.
Axiom proof_of_IntList_length_partial_solve_wit_2 : IntList_length_partial_solve_wit_2.
Axiom proof_of_IntList_length_precondition_wit_1 : IntList_length_precondition_wit_1.

End VC_Correct.
