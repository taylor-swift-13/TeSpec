From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push -----*)

Definition push_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size_2: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (d___tespec_entry <> 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (x_pre = (INT_MIN))) (PreH5 : (d___tespec_entry = 8192)) (PreH6 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH7 : (x0___tespec_entry = (INT_MIN))) (PreH8 : (x_pre = x0___tespec_entry)) (PreH9 : (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH10 : (0 <= retval)) (PreH11 : (retval <= UINT_MAX)),
  (sll retval (cons (x_pre) (l___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> (p_size_2 + 1 ))
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> retval)
|--
  EX (d2: Z) (p_size: Z),
  “ (d2 <> 0) ”
  &&  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d2)
  **  (sll d2 (cons (x0___tespec_entry) (l___tespec_entry)) )
.

Definition push_partial_solve_wit_1_pure :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x_pre = (INT_MIN))) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (x0___tespec_entry = (INT_MIN))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  ((( &( "data_spec_521" ) )) # Ptr  |->_)
  **  ((( &( "p_spec_496" ) )) # Ptr  |-> p_pre)
  **  ((( &( "x_spec_494" ) )) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  “ (x_pre = x_pre) ”
.

Definition push_partial_solve_wit_1_aux :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x_pre = (INT_MIN))) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (l___tespec_entry = (cons (1) ((@nil Z))))) (PreH6 : (x0___tespec_entry = (INT_MIN))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  “ (x_pre = x_pre) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (INT_MIN)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (x0___tespec_entry = (INT_MIN)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll d___tespec_entry l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition push_partial_solve_wit_1 := push_partial_solve_wit_1_pure -> push_partial_solve_wit_1_aux.

Definition push_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (x0___tespec_entry: Z),
exists (d___tespec_entry: Z),
exists (p_pre: Z),
exists (x_pre: Z),
~ ((  EX (p_size: Z),
  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (INT_MIN)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons (1) ((@nil Z)))) ”
  &&  “ (x0___tespec_entry = (INT_MIN)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_return_wit_1 : push_return_wit_1.
Axiom proof_of_push_partial_solve_wit_1_pure : push_partial_solve_wit_1_pure.
Axiom proof_of_push_partial_solve_wit_1 : push_partial_solve_wit_1.
Axiom proof_of_push_precondition_wit_1 : push_precondition_wit_1.

End VC_Correct.
