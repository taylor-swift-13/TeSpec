From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function leaky_get -----*)

Definition leaky_get_return_wit_1 :=
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 5)),
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  “ (v___tespec_entry = v___tespec_entry) ”
  &&  emp
) \/
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (v___tespec_entry <= UINT_MAX)) (PreH2 : (v___tespec_entry >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 5)),
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  TT && emp 
).

Definition leaky_get_return_wit_1_split_goal_spatial :=
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (v___tespec_entry <= UINT_MAX)) (PreH2 : (v___tespec_entry >= 0)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 5)),
  ((p_pre) # UInt  |-> v___tespec_entry)
|--
  TT && emp 
.

Definition leaky_get_precondition_wit_1 :=
exists (v___tespec_entry: Z),
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (v___tespec_entry = 5) ”
  &&  ((p_pre) # UInt  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_leaky_get_return_wit_1 : leaky_get_return_wit_1.
Axiom proof_of_leaky_get_precondition_wit_1 : leaky_get_precondition_wit_1.

End VC_Correct.
