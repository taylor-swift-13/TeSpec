From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

(*----- Function zero -----*)

Definition zero_return_wit_1 :=
(
forall (p_pre: Z) (PreH1 : (p_pre = 4096)),
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
) \/
(
forall (p_pre: Z) (PreH1 : (p_pre = 4096)),
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
).

Definition zero_return_wit_1_split_goal_spatial :=
forall (p_pre: Z) (PreH1 : (p_pre = 4096)),
  ((p_pre) # Int  |->_)
|--
  ((p_pre) # Int  |-> 0)
.

Definition zero_precondition_wit_1 :=
exists (p_pre: Z),
~ ((  “ (p_pre = 4096) ”
  &&  ((p_pre) # Int  |->_)) |-- “ False ”).

Module Type VC_Correct.

Axiom proof_of_zero_return_wit_1 : zero_return_wit_1.
Axiom proof_of_zero_precondition_wit_1 : zero_precondition_wit_1.

End VC_Correct.
