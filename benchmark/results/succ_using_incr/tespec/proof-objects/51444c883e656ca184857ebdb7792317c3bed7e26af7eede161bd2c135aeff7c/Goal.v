From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function succ_using_incr_attempt -----*)

Definition succ_using_incr_attempt_safety_wit_1 :=
forall (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (0 <= retval)) (PreH3 : (retval <= UINT_MAX)),
  ((( &( "m_spec_399" ) )) # UInt  |->_)
  **  ((( &( "n_spec_397" ) )) # UInt  |-> UINT_MAX)
  **  ((( &( "p_spec_435" ) )) # Ptr  |-> retval)
  **  ((retval) # UInt  |-> UINT_MAX)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> retval)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> UINT_MAX)
|--
  TT && emp 
.

Definition succ_using_incr_attempt_entail_wit_1 :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (unsigned_last_nbits ((n_pre + 1 )) (32)))
|--
  “ (retval <> 0) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> ((n_pre + 1 ) % ( 4294967296 ) ))
.

Definition succ_using_incr_attempt_entail_wit_2 :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval_2)) (PreH8 : (retval_2 <= UINT_MAX)),
  ((retval_2) # UInt  |->_)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (retval <> 0) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  ((retval) # UInt  |->_)
.

Definition succ_using_incr_attempt_entail_wit_3 :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval_2: Z) (PreH1 : (retval_2 <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval_2)) (PreH8 : (retval_2 <= UINT_MAX)),
  ((retval_2) # UInt  |-> n_pre)
|--
  EX (retval: Z),
  “ (retval = retval_2) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  ((retval) # UInt  |-> n_pre)
.

Definition succ_using_incr_attempt_return_wit_1 :=
(
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (unsigned_last_nbits ((n_pre + 1 )) (32)))
|--
  “ ((unsigned_last_nbits ((n_pre + 1 )) (32)) = ((v___tespec_entry + 1 ) % ( 4294967296 ) )) ”
  &&  emp
) \/
(
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : ((unsigned_last_nbits ((n_pre + 1 )) (32)) <= UINT_MAX)) (PreH2 : ((unsigned_last_nbits ((n_pre + 1 )) (32)) >= 0)) (PreH3 : (retval <> 0)) (PreH4 : (n_pre = UINT_MAX)) (PreH5 : (v___tespec_entry = UINT_MAX)) (PreH6 : (0 <= v___tespec_entry)) (PreH7 : (v___tespec_entry <= UINT_MAX)) (PreH8 : (n_pre = v___tespec_entry)) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (unsigned_last_nbits ((n_pre + 1 )) (32)))
|--
  TT && emp 
).

Definition succ_using_incr_attempt_return_wit_1_split_goal_spatial :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : ((unsigned_last_nbits ((n_pre + 1 )) (32)) <= UINT_MAX)) (PreH2 : ((unsigned_last_nbits ((n_pre + 1 )) (32)) >= 0)) (PreH3 : (retval <> 0)) (PreH4 : (n_pre = UINT_MAX)) (PreH5 : (v___tespec_entry = UINT_MAX)) (PreH6 : (0 <= v___tespec_entry)) (PreH7 : (v___tespec_entry <= UINT_MAX)) (PreH8 : (n_pre = v___tespec_entry)) (PreH9 : (0 <= retval)) (PreH10 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> (unsigned_last_nbits ((n_pre + 1 )) (32)))
|--
  TT && emp 
.

Definition succ_using_incr_attempt_partial_solve_wit_1_pure :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> n_pre)
  **  ((( &( "p_spec_422" ) )) # Ptr  |-> retval)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
.

Definition succ_using_incr_attempt_partial_solve_wit_1_aux :=
forall (v___tespec_entry: Z) (n_pre: Z) (retval: Z) (PreH1 : (retval <> 0)) (PreH2 : (n_pre = UINT_MAX)) (PreH3 : (v___tespec_entry = UINT_MAX)) (PreH4 : (0 <= v___tespec_entry)) (PreH5 : (v___tespec_entry <= UINT_MAX)) (PreH6 : (n_pre = v___tespec_entry)) (PreH7 : (0 <= retval)) (PreH8 : (retval <= UINT_MAX)),
  ((retval) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (retval <> 0) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  “ (0 <= retval) ”
  &&  “ (retval <= UINT_MAX) ”
  &&  ((retval) # UInt  |-> n_pre)
.

Definition succ_using_incr_attempt_partial_solve_wit_1 := succ_using_incr_attempt_partial_solve_wit_1_pure -> succ_using_incr_attempt_partial_solve_wit_1_aux.

Definition succ_using_incr_attempt_partial_solve_wit_2_pure :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = UINT_MAX)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  ((( &( "p_spec_422" ) )) # Ptr  |->_)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> n_pre)
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (n_pre = n_pre) ”
.

Definition succ_using_incr_attempt_partial_solve_wit_2_aux :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = UINT_MAX)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  TT && emp 
|--
  “ (0 <= n_pre) ”
  &&  “ (n_pre <= UINT_MAX) ”
  &&  “ (n_pre = n_pre) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp
.

Definition succ_using_incr_attempt_partial_solve_wit_2 := succ_using_incr_attempt_partial_solve_wit_2_pure -> succ_using_incr_attempt_partial_solve_wit_2_aux.

Definition succ_using_incr_attempt_partial_solve_wit_3 :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = UINT_MAX)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  TT && emp 
|--
  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp
.

Definition succ_using_incr_attempt_partial_solve_wit_4_pure :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = UINT_MAX)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  ((( &( "res_spec_409" ) )) # Ptr  |->_)
  **  ((( &( "v_spec_427" ) )) # UInt  |-> n_pre)
  **  ((( &( "p_spec_422" ) )) # Ptr  |->_)
  **  ((( &( "n_spec_411" ) )) # UInt  |-> n_pre)
|--
  “ (sizeof(UINT) = 4) ”
.

Definition succ_using_incr_attempt_partial_solve_wit_4_aux :=
forall (v___tespec_entry: Z) (n_pre: Z) (PreH1 : (n_pre = UINT_MAX)) (PreH2 : (v___tespec_entry = UINT_MAX)) (PreH3 : (0 <= v___tespec_entry)) (PreH4 : (v___tespec_entry <= UINT_MAX)) (PreH5 : (n_pre = v___tespec_entry)),
  TT && emp 
|--
  “ (sizeof(UINT) = 4) ”
  &&  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp
.

Definition succ_using_incr_attempt_partial_solve_wit_4 := succ_using_incr_attempt_partial_solve_wit_4_pure -> succ_using_incr_attempt_partial_solve_wit_4_aux.

Definition succ_using_incr_attempt_precondition_wit_1 :=
exists (v___tespec_entry: Z),
exists (n_pre: Z),
~ ((  “ (n_pre = UINT_MAX) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  “ (0 <= v___tespec_entry) ”
  &&  “ (v___tespec_entry <= UINT_MAX) ”
  &&  “ (n_pre = v___tespec_entry) ”
  &&  emp) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_succ_using_incr_attempt_safety_wit_1 : succ_using_incr_attempt_safety_wit_1.
Axiom proof_of_succ_using_incr_attempt_entail_wit_1 : succ_using_incr_attempt_entail_wit_1.
Axiom proof_of_succ_using_incr_attempt_entail_wit_2 : succ_using_incr_attempt_entail_wit_2.
Axiom proof_of_succ_using_incr_attempt_entail_wit_3 : succ_using_incr_attempt_entail_wit_3.
Axiom proof_of_succ_using_incr_attempt_return_wit_1 : succ_using_incr_attempt_return_wit_1.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_1_pure : succ_using_incr_attempt_partial_solve_wit_1_pure.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_1 : succ_using_incr_attempt_partial_solve_wit_1.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_2_pure : succ_using_incr_attempt_partial_solve_wit_2_pure.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_2 : succ_using_incr_attempt_partial_solve_wit_2.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_3 : succ_using_incr_attempt_partial_solve_wit_3.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_4_pure : succ_using_incr_attempt_partial_solve_wit_4_pure.
Axiom proof_of_succ_using_incr_attempt_partial_solve_wit_4 : succ_using_incr_attempt_partial_solve_wit_4.
Axiom proof_of_succ_using_incr_attempt_precondition_wit_1 : succ_using_incr_attempt_precondition_wit_1.

End VC_Correct.
