From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function main -----*)

Definition main_safety_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "p_spec_400" ) )) # Ptr  |-> retval)
|--
  TT && emp 
.

Definition main_entail_wit_1 :=
(
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  TT && emp 
|--
  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # Int  |->_)
) \/
(
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  TT && emp 
|--
  EX (x: Z),
  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # Int  |-> x)
).

Definition main_entail_wit_2 :=
forall (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (0 <= retval_2)) (PreH3 : (retval_2 <= UINT_MAX)),
  ((retval_2) # Int  |->_)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  ((retval) # Int  |->_)
.

Definition main_return_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  TT && emp 
|--
  “ (0 = 0) ”
  &&  emp
.

Definition main_partial_solve_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # Int  |->_)
.

Definition main_partial_solve_wit_2_pure :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "p_spec_407" ) )) # Ptr  |-> retval)
  **  ((retval) # Int  |->_)
  **  ((( &( "p_spec_400" ) )) # Ptr  |-> retval)
|--
  “ (sizeof(INT) = 4) ”
.

Definition main_partial_solve_wit_2_aux :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((retval) # Int  |->_)
|--
  “ (sizeof(INT) = 4) ”
  &&  “ (retval <> 0) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # Int  |->_)
.

Definition main_partial_solve_wit_2 := main_partial_solve_wit_2_pure -> main_partial_solve_wit_2_aux.

Definition main_partial_solve_wit_3 :=
  TT && emp 
|--
  TT && emp 
.

Definition main_partial_solve_wit_4_pure :=
  ((( &( "p_spec_400" ) )) # Ptr  |->_)
|--
  “ (sizeof(INT) = 4) ”
.

Definition main_partial_solve_wit_4_aux :=
  TT && emp 
|--
  “ (sizeof(INT) = 4) ”
  &&  emp
.

Definition main_partial_solve_wit_4 := main_partial_solve_wit_4_pure -> main_partial_solve_wit_4_aux.

Definition main_precondition_wit_1 :=
~ ((  TT && emp ) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_main_safety_wit_1 : main_safety_wit_1.
Axiom proof_of_main_entail_wit_1 : main_entail_wit_1.
Axiom proof_of_main_entail_wit_2 : main_entail_wit_2.
Axiom proof_of_main_return_wit_1 : main_return_wit_1.
Axiom proof_of_main_partial_solve_wit_1 : main_partial_solve_wit_1.
Axiom proof_of_main_partial_solve_wit_2_pure : main_partial_solve_wit_2_pure.
Axiom proof_of_main_partial_solve_wit_2 : main_partial_solve_wit_2.
Axiom proof_of_main_partial_solve_wit_3 : main_partial_solve_wit_3.
Axiom proof_of_main_partial_solve_wit_4_pure : main_partial_solve_wit_4_pure.
Axiom proof_of_main_partial_solve_wit_4 : main_partial_solve_wit_4.
Axiom proof_of_main_precondition_wit_1 : main_precondition_wit_1.

End VC_Correct.
