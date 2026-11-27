From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntQueue_pop_precondition_wit_1 : Goal.IntQueue_pop_precondition_wit_1.
Proof.
  unfold Goal.IntQueue_pop_precondition_wit_1.
  exists (0 :: INT_MIN :: nil), INT_MAX, 4096.
Abort.

End Proofs.
