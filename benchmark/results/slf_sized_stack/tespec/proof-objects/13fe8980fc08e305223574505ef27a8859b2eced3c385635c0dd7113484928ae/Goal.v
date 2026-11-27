From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function top -----*)

Definition top_safety_wit_1 :=
forall (p_size: Z) (PreH1 : (p_size = 3)),
  ((( &( "p_spec_513" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))) )
|--
  TT && emp 
.

Definition top_safety_wit_2 :=
forall (p_size: Z) (PreH1 : False),
  ((( &( "p_spec_513" ) )) # Ptr  |-> 4096)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (4096 + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (4096 + 4)) # Ptr  |-> 8192)
  **  (sll 8192 (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))) )
|--
  “ False ”
.

Definition top_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (PreH1 : (y_3 = 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_2 <> 0)) (PreH4 : (y <> 0)) (PreH5 : (d___tespec_entry <> 0)) (PreH6 : (d___tespec_entry <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (d___tespec_entry = 8192)) (PreH9 : (h___tespec_entry = (-1))) (PreH10 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH11 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH12 : (p_size_2 = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> h___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
|--
  EX (p_size: Z),
  “ (d___tespec_entry <> 0) ”
  &&  “ (h___tespec_entry = h___tespec_entry) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )
.

Definition top_partial_solve_wit_1 :=
forall (l___tespec_entry: (@list Z)) (h___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (d___tespec_entry <> 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (h___tespec_entry = (-1))) (PreH6 : (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z))))))) (PreH7 : ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0)) (PreH8 : (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (d___tespec_entry <> 0) ”
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

Definition top_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (h___tespec_entry: Z),
exists (d___tespec_entry: Z),
exists (p_pre: Z),
~ ((  EX (p_size: Z),
  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (h___tespec_entry = (-1)) ”
  &&  “ (l___tespec_entry = (cons (0) ((cons (3) ((@nil Z)))))) ”
  &&  “ ((((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) ) > 0) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry (cons (h___tespec_entry) (l___tespec_entry)) )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_top_safety_wit_1 : top_safety_wit_1.
Axiom proof_of_top_safety_wit_2 : top_safety_wit_2.
Axiom proof_of_top_return_wit_1 : top_return_wit_1.
Axiom proof_of_top_partial_solve_wit_1 : top_partial_solve_wit_1.
Axiom proof_of_top_precondition_wit_1 : top_precondition_wit_1.

End VC_Correct.
