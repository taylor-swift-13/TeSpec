From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_safety_wit_2 :=
  ((( &( "p_spec_400" ) )) # Ptr  |->_)
|--
  TT && emp 
.

Definition main_return_wit_1 :=
(
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
|--
  “ (0 = 0) ”
  &&  emp
) \/
(
forall (retval: Z) (PreH1 : (5 <= UINT_MAX)) (PreH2 : (5 >= 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
|--
  TT && emp 
).

Definition main_return_wit_1_split_goal_spatial :=
forall (retval: Z) (PreH1 : (5 <= UINT_MAX)) (PreH2 : (5 >= 0)) (PreH3 : (0 <= retval)) (PreH4 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> 5)
|--
  TT && emp 
.

Definition main_partial_solve_wit_1_pure :=
  ((( &( "p_spec_400" ) )) # Ptr  |->_)
|--
  “ (0 <= 5) ”
  &&  “ (5 <= UINT_MAX) ”
  &&  “ (5 = 5) ”
.

Definition main_partial_solve_wit_1_aux :=
  TT && emp 
|--
  “ (0 <= 5) ”
  &&  “ (5 <= UINT_MAX) ”
  &&  “ (5 = 5) ”
  &&  emp
.

Definition main_partial_solve_wit_1 := main_partial_solve_wit_1_pure -> main_partial_solve_wit_1_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_safety_wit_2 : main_safety_wit_2.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1_pure : main_partial_solve_wit_1_pure.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
