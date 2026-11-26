From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_return_wit_1 :=
(
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  “ (0 = 0) ”
  &&  emp
) \/
(
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  TT && emp 
).

Definition main_return_wit_1_split_goal_spatial :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  TT && emp 
.

Definition main_partial_solve_wit_1 :=
forall (retval: Z) (PreH1 : (0 <= retval)) (PreH2 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # Int  |->_)
.

Definition main_partial_solve_wit_2 :=
  TT && emp 
|--
  TT && emp 
.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
