From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_push_precondition_wit_1 : Goal.push_precondition_wit_1.
Proof.
  unfold Goal.push_precondition_wit_1.
  exists (@nil Z), 7, 0, 4096, 7.
Abort.

End Proofs.
