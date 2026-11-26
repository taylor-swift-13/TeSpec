From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function pop -----*)

Definition pop_safety_wit_1 :=
forall (p_size: Z) (PreH1 : (p_size = 3)),
  ((( &( "data_spec_552" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_527" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition pop_safety_wit_2 :=
forall (p_size: Z) (PreH1 : False),
  ((( &( "data_spec_552" ) )) # Ptr  |-> 8192)
  **  ((( &( "p_spec_527" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))) )
|--
  “ False ”
.

Definition pop_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (d___tespec_entry <> 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (h___tespec_entry = (-1))) (PreH6 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH7 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH8 : (p_size_2 = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> (p_size_2 - 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> y)
|--
  EX (d2: Z) (p_size: Z),
  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d2)
  **  (sll d2 l___tespec_entry )
) \/
(
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : (3 <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : (3 >= INT_MIN)) (PreH5 : (y_3 = 0)) (PreH6 : (d___tespec_entry <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (d___tespec_entry = 8192)) (PreH9 : (h___tespec_entry = (-1))) (PreH10 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH11 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH12 : (p_size_2 = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  (sll y l___tespec_entry )
).

Definition pop_return_wit_1_split_goal_spatial :=
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (0 <= INT_MAX)) (PreH2 : (3 <= INT_MAX)) (PreH3 : (0 >= INT_MIN)) (PreH4 : (3 >= INT_MIN)) (PreH5 : (y_3 = 0)) (PreH6 : (d___tespec_entry <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (d___tespec_entry = 8192)) (PreH9 : (h___tespec_entry = (-1))) (PreH10 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH11 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH12 : (p_size_2 = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
|--
  (sll y l___tespec_entry )
.

Definition pop_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (d___tespec_entry <> 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (h___tespec_entry = (-1))) (PreH6 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH7 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH8 : (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
|--
  “ (y_3 = 0) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (h___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z)))))) ”
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |->_)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition pop_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (h___tespec_entry = (-1))) (PreH5 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH6 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH7 : (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (h___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z)))))) ”
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition pop_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h___tespec_entry: Z),
exists (d___tespec_entry: Z),
exists (p_pre: Z),
~ ((  EX (p_size: Z),
  “ (p_pre = 4096) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (h___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z)))))) ”
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_pop_safety_wit_1 : pop_safety_wit_1.
Axiom proof_of_pop_safety_wit_2 : pop_safety_wit_2.
Axiom proof_of_pop_return_wit_1 : pop_return_wit_1.
Axiom proof_of_pop_partial_solve_wit_1 : pop_partial_solve_wit_1.
Axiom proof_of_pop_partial_solve_wit_2 : pop_partial_solve_wit_2.
Axiom proof_of_pop_precondition_wit_1 : pop_precondition_wit_1.

End VC_Correct.
