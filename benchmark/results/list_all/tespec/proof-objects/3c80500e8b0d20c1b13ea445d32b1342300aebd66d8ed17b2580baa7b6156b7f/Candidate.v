From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_rev_aux_precondition_wit_1 : Goal.IntList_rev_aux_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_aux_precondition_wit_1.
  exists (cons (1%Z) (@nil Z)).
  exists (@nil Z).
  exists (0%Z).
  exists (16384%Z).
Abort.

End Proofs.
