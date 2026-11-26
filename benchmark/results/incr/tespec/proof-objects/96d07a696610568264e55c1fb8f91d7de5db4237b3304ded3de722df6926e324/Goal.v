From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function incr -----*)

Definition incr_safety_wit_1 :=
  ((( &( "m_spec_381" ) )) # UInt  |->_)
  **  ((( &( "n_spec_379" ) )) # UInt  |-> 1)
  **  ((( &( "p_spec_370" ) )) # Ptr  |-> 4096)
  **  ((4096) # UInt  |-> 1)
|--
  TT && emp 
.

Definition incr_return_wit_1 :=
(
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (old___tespec_entry = 1)) (PreH3 : (0 <= old___tespec_entry)) (PreH4 : (old___tespec_entry <= UINT_MAX)),
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
) \/
(
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : ((old___tespec_entry + 1 ) <= UINT_MAX)) (PreH2 : ((old___tespec_entry + 1 ) >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 1)) (PreH5 : (0 <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= UINT_MAX)),
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
).

Definition incr_return_wit_1_split_goal_spatial :=
forall (old___tespec_entry: Z) (p_pre: Z) (PreH1 : ((old___tespec_entry + 1 ) <= UINT_MAX)) (PreH2 : ((old___tespec_entry + 1 ) >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (old___tespec_entry = 1)) (PreH5 : (0 <= old___tespec_entry)) (PreH6 : (old___tespec_entry <= UINT_MAX)),
  ((p_pre) # UInt  |-> (old___tespec_entry + 1 ))
|--
  TT && emp 
.

Definition incr_precondition_wit_1 :=
exists (old___tespec_entry: Z),
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (old___tespec_entry = 1) ”
  &&  “ (0 <= old___tespec_entry) ”
  &&  “ (old___tespec_entry <= UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> old___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_incr_safety_wit_1 : incr_safety_wit_1.
Axiom proof_of_incr_return_wit_1 : incr_return_wit_1.
Axiom proof_of_incr_precondition_wit_1 : incr_precondition_wit_1.

End VC_Correct.
