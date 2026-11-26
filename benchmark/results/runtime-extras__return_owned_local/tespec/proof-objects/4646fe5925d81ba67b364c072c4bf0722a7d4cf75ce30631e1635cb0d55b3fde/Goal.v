From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "p_spec_410" ) )) # Ptr  |-> ( &( "p_spec_423" ) ))
  **  ((( &( "res_spec_408" ) )) # UInt  |-> 5)
  **  ((retval) # UInt  |-> 6)
  **  ((( &( "x_spec_406" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_safety_wit_2 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "res_spec_408" ) )) # UInt  |-> 5)
  **  ((retval) # UInt  |-> 5)
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

Definition main_entail_wit_1 :=
(
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  EX (retval_2: Z),
  “ (retval_2 = ( &( "p_spec_423" ) )) ”
  &&  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 6)
  **  ((retval_2) # Ptr  |-> retval)
) \/
(
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  TT && emp 
|--
  ((( &( "p_spec_423" ) )) # Ptr  |-> retval)
).

Definition main_entail_wit_1_split_goal_spatial :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  TT && emp 
|--
  ((( &( "p_spec_423" ) )) # Ptr  |-> retval)
.

Definition main_entail_wit_2 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
|--
  EX (retval_2: Z),
  “ (retval_2 = 5) ”
  &&  “ (retval_2 = 5) ”
  &&  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> 5)
.

Definition main_return_wit_1 :=
(
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  “ (0 = 0) ”
  &&  emp
) \/
(
forall (retval: Z) (PreH1 : (6 <= UINT_MAX)) (PreH2 : (6 >= 0)) (PreH3 : (retval <> 0)) (PreH4 : (0 <= retval)) (PreH5 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  TT && emp 
).

Definition main_return_wit_1_split_goal_spatial :=
forall (retval: Z) (PreH1 : (6 <= UINT_MAX)) (PreH2 : (6 >= 0)) (PreH3 : (retval <> 0)) (PreH4 : (0 <= retval)) (PreH5 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  TT && emp 
.

Definition main_partial_solve_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 6)
|--
  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
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
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3_pure : main_partial_solve_wit_3_pure.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
