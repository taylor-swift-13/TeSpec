From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function push -----*)

Definition push_entail_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (x_pre = (-1))) (PreH5 : (d___tespec_entry = 8192)) (PreH6 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH7 : (x0___tespec_entry = (-1))) (PreH8 : (x_pre = x0___tespec_entry)) (PreH9 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH10 : (0 <= retval_2)) (PreH11 : (retval_2 <= UINT_MAX)),
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
) \/
(
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : (3 <= INT_MAX)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : (3 >= INT_MIN)) (PreH7 : (retval_2 <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (p_pre = 4096)) (PreH10 : (x_pre = (-1))) (PreH11 : (d___tespec_entry = 8192)) (PreH12 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH13 : (x0___tespec_entry = (-1))) (PreH14 : (x_pre = x0___tespec_entry)) (PreH15 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH16 : (0 <= retval_2)) (PreH17 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
|--
  (sll d___tespec_entry l___tespec_entry )
).

Definition push_entail_wit_1_split_goal_spatial :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (y: Z) (y_2: Z) (y_3: Z) (retval_2: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : (3 <= INT_MAX)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : (3 >= INT_MIN)) (PreH7 : (retval_2 <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (p_pre = 4096)) (PreH10 : (x_pre = (-1))) (PreH11 : (d___tespec_entry = 8192)) (PreH12 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH13 : (x0___tespec_entry = (-1))) (PreH14 : (x_pre = x0___tespec_entry)) (PreH15 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH16 : (0 <= retval_2)) (PreH17 : (retval_2 <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
|--
  (sll d___tespec_entry l___tespec_entry )
.

Definition push_return_wit_1 :=
(
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (y_3 = 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (x_pre = (-1))) (PreH5 : (d___tespec_entry = 8192)) (PreH6 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH7 : (x0___tespec_entry = (-1))) (PreH8 : (x_pre = x0___tespec_entry)) (PreH9 : (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH10 : (0 <= retval)) (PreH11 : (retval <= UINT_MAX)),
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
  “ (p_size = (((Zlength (l___tespec_entry)) + 1 ) % ( 4294967296 ) )) ”
  &&  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d2)
  **  (sll d2 (cons (x0___tespec_entry) (l___tespec_entry)) )
) \/
(
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : (3 <= INT_MAX)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : (3 >= INT_MIN)) (PreH7 : (retval <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (p_pre = 4096)) (PreH10 : (x_pre = (-1))) (PreH11 : (d___tespec_entry = 8192)) (PreH12 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH13 : (x0___tespec_entry = (-1))) (PreH14 : (x_pre = x0___tespec_entry)) (PreH15 : (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH16 : (0 <= retval)) (PreH17 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
|--
  (sll d___tespec_entry l___tespec_entry )
).

Definition push_return_wit_1_split_goal_spatial :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size_2: Z) (y: Z) (y_2: Z) (y_3: Z) (retval: Z) (PreH1 : ((-1) <= INT_MAX)) (PreH2 : (0 <= INT_MAX)) (PreH3 : (3 <= INT_MAX)) (PreH4 : ((-1) >= INT_MIN)) (PreH5 : (0 >= INT_MIN)) (PreH6 : (3 >= INT_MIN)) (PreH7 : (retval <> 0)) (PreH8 : (y_3 = 0)) (PreH9 : (p_pre = 4096)) (PreH10 : (x_pre = (-1))) (PreH11 : (d___tespec_entry = 8192)) (PreH12 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH13 : (x0___tespec_entry = (-1))) (PreH14 : (x_pre = x0___tespec_entry)) (PreH15 : (p_size_2 = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))) (PreH16 : (0 <= retval)) (PreH17 : (retval <= UINT_MAX)),
  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y_2 + 4)) # Ptr  |-> y_3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y_2 + 0)) # Int  |-> 3)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (y + 4)) # Ptr  |-> y_2)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (y + 0)) # Int  |-> 0)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (d___tespec_entry + 4)) # Ptr  |-> y)
  **  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (d___tespec_entry + 0)) # Int  |-> (-1))
|--
  (sll d___tespec_entry l___tespec_entry )
.

Definition push_partial_solve_wit_1_pure :=
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x_pre = (-1))) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH5 : (x0___tespec_entry = (-1))) (PreH6 : (x_pre = x0___tespec_entry)) (PreH7 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
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
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x_pre = (-1))) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH5 : (x0___tespec_entry = (-1))) (PreH6 : (x_pre = x0___tespec_entry)) (PreH7 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  “ (x_pre = x_pre) ”
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
forall (l___tespec_entry: (@list Z)) (x0___tespec_entry: Z) (d___tespec_entry: Z) (p_pre: Z) (x_pre: Z) (p_size: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (x_pre = (-1))) (PreH3 : (d___tespec_entry = 8192)) (PreH4 : (l___tespec_entry = (cons ((-1)) ((cons (0) ((cons (3) ((@nil Z))))))))) (PreH5 : (x0___tespec_entry = (-1))) (PreH6 : (x_pre = x0___tespec_entry)) (PreH7 : (p_size = ((Zlength (l___tespec_entry)) % ( 4294967296 ) ))),
  (((* tespec-target-field-address-v1: bits=32; offset=0; size=4; align=4 *) (p_pre + 0)) # UInt  |-> p_size)
  **  (((* tespec-target-field-address-v1: bits=32; offset=4; size=4; align=4 *) (p_pre + 4)) # Ptr  |-> d___tespec_entry)
  **  (sll d___tespec_entry l___tespec_entry )
|--
  EX (y: Z) (y_2: Z) (y_3: Z),
  “ (y_3 = 0) ”
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
  “ (p_pre = 4096) ”
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
