From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function bad -----*)

Definition bad_return_wit_1 :=
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = UINT_MAX)),
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  ((p_pre) # UInt  |-> v___tespec_entry)
  **  ((( &( "p_spec_394" ) )) # Ptr  |-> p_pre)
) \/
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = UINT_MAX)),
  TT && emp 
|--
  ((( &( "p_spec_394" ) )) # Ptr  |-> p_pre)
).

Definition bad_return_wit_1_split_goal_spatial :=
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = UINT_MAX)),
  TT && emp 
|--
  ((( &( "p_spec_394" ) )) # Ptr  |-> p_pre)
.

Definition bad_precondition_wit_1 :=
exists (v___tespec_entry: Z),
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (v___tespec_entry = UINT_MAX) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_bad_return_wit_1 : bad_return_wit_1.
Axiom proof_of_bad_precondition_wit_1 : bad_precondition_wit_1.

End VC_Correct.
