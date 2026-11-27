From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntQueue_pop_precondition_wit_1 : Goal.IntQueue_pop_precondition_wit_1.
Proof.
  unfold Goal.IntQueue_pop_precondition_wit_1.
  exists (cons (-1)%Z (@nil Z)), 2%Z, 4096%Z.
Abort.

End Proofs.
