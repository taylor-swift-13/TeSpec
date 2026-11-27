From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_append_precondition_wit_1 : Goal.IntList_append_precondition_wit_1.
Proof.
  unfold Goal.IntList_append_precondition_wit_1.
  exists (cons 1 (@nil Z)), (@nil Z), 0, 16384.
  intro Hunsat.
Abort.

End Proofs.
