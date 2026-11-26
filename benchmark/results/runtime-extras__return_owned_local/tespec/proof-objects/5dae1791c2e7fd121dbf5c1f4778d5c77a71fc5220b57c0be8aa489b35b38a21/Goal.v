From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 :=
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)) (PreH5 : (0 <= retval_3)) (PreH6 : (retval_3 <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
  **  ((retval_3) # Ptr  |-> retval)
  **  ((( &( "p_spec_410" ) )) # Ptr  |-> retval_3)
  **  ((( &( "res_spec_408" ) )) # UInt  |-> 5)
  **  ((( &( "x_spec_406" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_safety_wit_2 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
  **  ((( &( "res_spec_408" ) )) # UInt  |-> 5)
  **  ((( &( "x_spec_406" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_safety_wit_3 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |->_)
  **  ((( &( "x_spec_406" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_return_wit_1 :=
(
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)) (PreH5 : (0 <= retval_2)) (PreH6 : (retval_2 <= UINT_MAX)) (PreH7 : (0 <= retval_3)) (PreH8 : (retval_3 <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
  **  ((retval_3) # Ptr  |-> retval)
|--
  “ (0 = 0) ”
  &&  emp
) \/
(
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (6 <= UINT_MAX)) (PreH2 : (6 >= 0)) (PreH3 : (retval_2 = 5)) (PreH4 : (retval <> 0)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)) (PreH7 : (0 <= retval_2)) (PreH8 : (retval_2 <= UINT_MAX)) (PreH9 : (0 <= retval_3)) (PreH10 : (retval_3 <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
  **  ((retval_3) # Ptr  |-> retval)
|--
  TT && emp 
).

Definition main_return_wit_1_split_goal_spatial :=
forall (retval: Z) (retval_2: Z) (retval_3: Z) (PreH1 : (6 <= UINT_MAX)) (PreH2 : (6 >= 0)) (PreH3 : (retval_2 = 5)) (PreH4 : (retval <> 0)) (PreH5 : (0 <= retval)) (PreH6 : (retval <= UINT_MAX)) (PreH7 : (0 <= retval_2)) (PreH8 : (retval_2 <= UINT_MAX)) (PreH9 : (0 <= retval_3)) (PreH10 : (retval_3 <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
  **  ((retval_3) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_partial_solve_wit_1 :=
forall (retval: Z) (retval_2: Z) (PreH1 : (retval_2 = 5)) (PreH2 : (retval <> 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)) (PreH5 : (0 <= retval_2)) (PreH6 : (retval_2 <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  “ (retval_2 = 5) ”
  &&  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  “ (0 <= retval_2) ”
  &&  “ (retval_2 <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 6)
.

Definition main_partial_solve_wit_2 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
|--
  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 5)
.

Definition main_partial_solve_wit_3_pure :=
  ((( &( "x_spec_406" ) )) # Ptr  |->_)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition main_partial_solve_wit_3_aux :=
  TT && emp 
|--
  “ (sizeof(UINT) = 4) ”
  &&  emp
.

Definition main_partial_solve_wit_3 := main_partial_solve_wit_3_pure -> main_partial_solve_wit_3_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_safety_wit_3 : main_safety_wit_3.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
