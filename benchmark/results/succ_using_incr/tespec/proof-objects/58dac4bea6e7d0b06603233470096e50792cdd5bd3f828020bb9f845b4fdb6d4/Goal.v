From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function succ_using_incr_attempt -----*)

Definition succ_using_incr_attempt_return_wit_1 :=
(
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (n_pre = 5)) (PreH2 : (v___tespec_entry = 5)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> ((n_pre + 1 ) % ( 4294967296 ) ))
|--
  “ (((n_pre + 1 ) % ( 4294967296 ) ) = ((v___tespec_entry + 1 ) % ( 4294967296 ) )) ”
  &&  emp
) \/
(
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (((n_pre + 1 ) % ( 4294967296 ) ) <= UINT_MAX)) (PreH2 : (((n_pre + 1 ) % ( 4294967296 ) ) >= 0)) (PreH3 : (n_pre = 5)) (PreH4 : (v___tespec_entry = 5)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = v___tespec_entry)) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> ((n_pre + 1 ) % ( 4294967296 ) ))
|--
  TT && emp 
).

Definition succ_using_incr_attempt_return_wit_1_split_goal_spatial :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (((n_pre + 1 ) % ( 4294967296 ) ) <= UINT_MAX)) (PreH2 : (((n_pre + 1 ) % ( 4294967296 ) ) >= 0)) (PreH3 : (n_pre = 5)) (PreH4 : (v___tespec_entry = 5)) (PreH5 : (0 <= v___tespec_entry)) (PreH6 : (v___tespec_entry <= UINT_MAX)) (PreH7 : (n_pre = v___tespec_entry)) (PreH8 : (0 <= retval)) (PreH9 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> ((n_pre + 1 ) % ( 4294967296 ) ))
|--
  TT && emp 
.

Definition succ_using_incr_attempt_partial_solve_wit_1_pure :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (n_pre = 5)) (PreH2 : (v___tespec_entry = 5)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> n_pre)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> retval)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
.

Definition succ_using_incr_attempt_partial_solve_wit_1_aux :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (n_pre = 5)) (PreH2 : (v___tespec_entry = 5)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)) (PreH6 : (0 <= retval)) (PreH7 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (n_pre = 5) ”
  &&  “ (v___tespec_entry = 5) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> n_pre)
.

Definition succ_using_incr_attempt_partial_solve_wit_1 := succ_using_incr_attempt_partial_solve_wit_1_pure -> succ_using_incr_attempt_partial_solve_wit_1_aux.

Definition succ_using_incr_attempt_partial_solve_wit_2_pure :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = 5)) (PreH2 : (v___tespec_entry = 5)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  ((( &( "p_spec_422" ) )) # Ptr  |->_)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (n_pre = n_pre) ”
.

Definition succ_using_incr_attempt_partial_solve_wit_2_aux :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = 5)) (PreH2 : (v___tespec_entry = 5)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  TT && emp 
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (n_pre = n_pre) ”
  &&  “ (n_pre = 5) ”
  &&  “ (v___tespec_entry = 5) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp
.

Definition succ_using_incr_attempt_partial_solve_wit_2 := succ_using_incr_attempt_partial_solve_wit_2_pure -> succ_using_incr_attempt_partial_solve_wit_2_aux.

Definition succ_using_incr_attempt_precondition_wit_1 :=
exists (v___tespec_entry: Z),
exists (n_pre: Z),
~ ((  “ (n_pre = 5) ”
  &&  “ (v___tespec_entry = 5) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_succ_using_incr_attempt_return_wit_1 : succ_using_incr_attempt_return_wit_1.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_1_pure : succ_using_incr_attempt_partial_solve_wit_1_pure.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_1 : succ_using_incr_attempt_partial_solve_wit_1.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_2_pure : succ_using_incr_attempt_partial_solve_wit_2_pure.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_2 : succ_using_incr_attempt_partial_solve_wit_2.
Axiom proof_of_succ_using_incr_attempt_precondition_wit_1 : succ_using_incr_attempt_precondition_wit_1.

End VC_Correct.
