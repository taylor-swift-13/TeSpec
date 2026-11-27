From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import TeSpecLayout_1c59d86d2590d95de97f91f1.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push -----*)

Definition push_entail_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (d___tespec_entry <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (x_pre = (-1))) (PreH9 : (d___tespec_entry = 8192)) (PreH10 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH11 : (x0___tespec_entry = (-1))) (PreH12 : (x_pre = x0___tespec_entry)) (PreH13 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH14 : (0 <= retval_2)) (PreH15 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval_2 + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval_2 + 4)) # Ptr  |-> d___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (-1)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll retval (cons (x_pre) (l___tespec_entry)) )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition push_return_wit_1 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (y_3 = 0)) (PreH4 : (y_2 <> 0)) (PreH5 : (y <> 0)) (PreH6 : (d___tespec_entry <> 0)) (PreH7 : (p_pre = 4096)) (PreH8 : (x_pre = (-1))) (PreH9 : (d___tespec_entry = 8192)) (PreH10 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH11 : (x0___tespec_entry = (-1))) (PreH12 : (x_pre = x0___tespec_entry)) (PreH13 : (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH14 : (0 <= retval)) (PreH15 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (retval + 0)) # Int  |-> x_pre)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (retval + 4)) # Ptr  |-> d___tespec_entry)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
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
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x_pre = (-1))) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
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
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x_pre = (-1))) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  “ (x_pre = x_pre) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (-1)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (sll d___tespec_entry l___tespec_entry )
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition push_partial_solve_wit_1 := push_partial_solve_wit_1_pure -> push_partial_solve_wit_1_aux.

Definition push_partial_solve_wit_2 :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (d___tespec_entry <> 0)) (PreH2 : (p_pre = 4096)) (PreH3 : (x_pre = (-1))) (PreH4 : (d___tespec_entry = 8192)) (PreH5 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH6 : (x0___tespec_entry = (-1))) (PreH7 : (x_pre = x0___tespec_entry)) (PreH8 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
  &&  “ (y_3 = 0) ”
  &&  “ (y_2 <> 0) ”
  &&  “ (y <> 0) ”
  &&  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (-1)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
.

Definition push_precondition_wit_1 :=
exists (l___tespec_entry: (@list Z)),
exists (x0___tespec_entry: Z),
exists (d___tespec_entry: Z),
exists (p_pre: Z),
exists (x_pre: Z),
~ ((  EX (p_size: Z),
  “ (d___tespec_entry <> 0) ”
  &&  “ (p_pre = 4096) ”
  &&  “ (x_pre = (-1)) ”
  &&  “ (d___tespec_entry = 8192) ”
  &&  “ (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z)))))))) ”
  &&  “ (x0___tespec_entry = (-1)) ”
  &&  “ (x_pre = x0___tespec_entry) ”
  &&  “ (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_push_entail_wit_1 : push_entail_wit_1.
Axiom proof_of_push_return_wit_1 : push_return_wit_1.
Axiom proof_of_push_partial_solve_wit_1_pure : push_partial_solve_wit_1_pure.
Axiom proof_of_push_partial_solve_wit_1 : push_partial_solve_wit_1.
Axiom proof_of_push_partial_solve_wit_2 : push_partial_solve_wit_2.
Axiom proof_of_push_precondition_wit_1 : push_precondition_wit_1.

End VC_Correct.
