From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function IntList_length_acc -----*)

Definition IntList_length_acc_safety_wit_1 :=
forall (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((( &( "p_spec_682" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_681" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_2 :=
forall (retval: Z) (PreH1 : False),
  ((( &( "p_spec_682" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_681" ) )) # Ptr  |-> 0)
  **  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 1)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_3 :=
forall (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_4 :=
forall (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  TT && emp 
.

Definition IntList_length_acc_safety_wit_5 :=
forall (y: Z) (retval: Z) (PreH1 : False),
  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> 8192)
  **  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (8192 + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (8192 + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
|--
  “ False ”
.

Definition IntList_length_acc_safety_wit_6 :=
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> 8192)
  **  (sll 8192 (cons (1) ((@nil Z))) )
|--
  TT && emp 
.

Definition IntList_length_acc_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (((0 + 1 ) + (Zlength ((@nil Z))) ) % ( 4294967296 ) ))
  **  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_entail_wit_2 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (retval <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((0 + (Zlength ((cons (1) ((@nil Z))))) ) % ( 4294967296 ) ))
  **  (sll xs_pre (cons (1) ((@nil Z))) )
.

Definition IntList_length_acc_entail_wit_3 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y_2: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_2 = 0)) (PreH3 : (y_2 = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (0 <= retval_2)) (PreH8 : (retval_2 <= UINT_MAX)),
  ((retval_2) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  EX (retval: Z) (y: Z),
  “ (retval = retval_2) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ ((0 + 1 ) = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll xs_pre l___tespec_entry )
.

Definition IntList_length_acc_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (y = 0)) (PreH2 : (xs_pre <> 0)) (PreH3 : (retval <> 0)) (PreH4 : (y = 0)) (PreH5 : (y = 0)) (PreH6 : (xs_pre <> 0)) (PreH7 : (xs_pre = 8192)) (PreH8 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_partial_solve_wit_2_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_2_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y = 0)) (PreH3 : (y = 0)) (PreH4 : (xs_pre <> 0)) (PreH5 : (xs_pre = 8192)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (retval <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 0)
  **  (sll xs_pre (cons (1) ((@nil Z))) )
.

Definition IntList_length_acc_partial_solve_wit_2 := IntList_length_acc_partial_solve_wit_2_pure -> IntList_length_acc_partial_solve_wit_2_aux.

Definition IntList_length_acc_partial_solve_wit_3_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y = 0)) (PreH4 : (y = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  ((( &( "p_spec_676" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_675" ) )) # Ptr  |-> xs_pre)
  **  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
  **  ((( &( "p_spec_657" ) )) # Ptr  |-> retval)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
|--
  “ (0 <= (0 + 1 )) ”
  &&  “ ((0 + 1 ) <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_3_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (y: Z) (retval: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (retval <> 0)) (PreH3 : (y = 0)) (PreH4 : (y = 0)) (PreH5 : (xs_pre <> 0)) (PreH6 : (xs_pre = 8192)) (PreH7 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (0 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
|--
  “ (0 <= (0 + 1 )) ”
  &&  “ ((0 + 1 ) <= UINT_MAX) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (retval <> 0) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> (0 + 1 ))
  **  (sll y (@nil Z) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_partial_solve_wit_3 := IntList_length_acc_partial_solve_wit_3_pure -> IntList_length_acc_partial_solve_wit_3_aux.

Definition IntList_length_acc_partial_solve_wit_4_pure :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  ((( &( "p_spec_657" ) )) # Ptr  |->_)
  **  ((( &( "xs_spec_646" ) )) # Ptr  |-> xs_pre)
  **  (sll xs_pre l___tespec_entry )
|--
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
.

Definition IntList_length_acc_partial_solve_wit_4_aux :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (0 <= 0) ”
  &&  “ (0 <= UINT_MAX) ”
  &&  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_partial_solve_wit_4 := IntList_length_acc_partial_solve_wit_4_pure -> IntList_length_acc_partial_solve_wit_4_aux.

Definition IntList_length_acc_partial_solve_wit_5 :=
forall (l___tespec_entry: (@list Z)) (xs_pre: Z) (PreH1 : (xs_pre <> 0)) (PreH2 : (xs_pre = 8192)) (PreH3 : (l___tespec_entry = (cons (1) ((@nil Z))))),
  (sll xs_pre l___tespec_entry )
|--
  EX (y: Z),
  “ (y = 0) ”
  &&  “ (y = 0) ”
  &&  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (xs_pre + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (xs_pre + 0)) # Int  |-> 1)
.

Definition IntList_length_acc_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (xs_pre: Z),
~ ((  “ (xs_pre <> 0) ”
  &&  “ (xs_pre = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  (sll xs_pre l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_IntList_length_acc_safety_wit_1 : IntList_length_acc_safety_wit_1.
Axiom proof_of_IntList_length_acc_safety_wit_2 : IntList_length_acc_safety_wit_2.
Axiom proof_of_IntList_length_acc_safety_wit_3 : IntList_length_acc_safety_wit_3.
Axiom proof_of_IntList_length_acc_safety_wit_4 : IntList_length_acc_safety_wit_4.
Axiom proof_of_IntList_length_acc_safety_wit_5 : IntList_length_acc_safety_wit_5.
Axiom proof_of_IntList_length_acc_safety_wit_6 : IntList_length_acc_safety_wit_6.
Axiom proof_of_IntList_length_acc_entail_wit_1 : IntList_length_acc_entail_wit_1.
Axiom proof_of_IntList_length_acc_entail_wit_2 : IntList_length_acc_entail_wit_2.
Axiom proof_of_IntList_length_acc_entail_wit_3 : IntList_length_acc_entail_wit_3.
Axiom proof_of_IntList_length_acc_return_wit_1 : IntList_length_acc_return_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_1 : IntList_length_acc_partial_solve_wit_1.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2_pure : IntList_length_acc_partial_solve_wit_2_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_2 : IntList_length_acc_partial_solve_wit_2.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3_pure : IntList_length_acc_partial_solve_wit_3_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_3 : IntList_length_acc_partial_solve_wit_3.
Axiom proof_of_IntList_length_acc_partial_solve_wit_4_pure : IntList_length_acc_partial_solve_wit_4_pure.
Axiom proof_of_IntList_length_acc_partial_solve_wit_4 : IntList_length_acc_partial_solve_wit_4.
Axiom proof_of_IntList_length_acc_partial_solve_wit_5 : IntList_length_acc_partial_solve_wit_5.
Axiom proof_of_IntList_length_acc_precondition_wit_1 : IntList_length_acc_precondition_wit_1.

End VC_Correct.
