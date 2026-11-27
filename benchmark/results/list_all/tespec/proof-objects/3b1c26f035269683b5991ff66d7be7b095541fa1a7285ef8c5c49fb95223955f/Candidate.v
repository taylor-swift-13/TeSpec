From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_append2_precondition_wit_1 : Goal.IntList_append2_precondition_wit_1.
Proof.
  unfold Goal.IntList_append2_precondition_wit_1.
  exists (@nil Z).
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists 8192.
  exists 0.
Abort.

End Proofs.
