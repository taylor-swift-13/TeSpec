From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function read -----*)

Definition read_return_wit_1 :=
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (p_pre = 4096)) (PreH2 : (v___tespec_entry = 7)),
  ((p_pre) # Int  |-> v___tespec_entry)
|--
  TT && emp 
) \/
(
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (v___tespec_entry <= INT_MAX)) (PreH2 : (v___tespec_entry >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 7)),
  ((p_pre) # Int  |-> v___tespec_entry)
|--
  TT && emp 
).

Definition read_return_wit_1_split_goal_spatial :=
forall (v___tespec_entry: Z) (p_pre: Z) (PreH1 : (v___tespec_entry <= INT_MAX)) (PreH2 : (v___tespec_entry >= INT_MIN)) (PreH3 : (p_pre = 4096)) (PreH4 : (v___tespec_entry = 7)),
  ((p_pre) # Int  |-> v___tespec_entry)
|--
  TT && emp 
.

Definition read_precondition_wit_1 :=
exists (v___tespec_entry: Z),
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  “ (v___tespec_entry = 7) ”
  &&  ((p_pre) # Int  |-> v___tespec_entry)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_read_return_wit_1 : read_return_wit_1.
Axiom proof_of_read_precondition_wit_1 : read_precondition_wit_1.

End VC_Correct.
