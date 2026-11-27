From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_append2_precondition_wit_1 : Goal.IntList_append2_precondition_wit_1.
Proof.
  unfold Goal.IntList_append2_precondition_wit_1.
  exists (cons 2 (cons (-1) (@nil Z))).
  exists (cons 1 (@nil Z)).
  exists 8192, 16384.
Abort.

End Proofs.
