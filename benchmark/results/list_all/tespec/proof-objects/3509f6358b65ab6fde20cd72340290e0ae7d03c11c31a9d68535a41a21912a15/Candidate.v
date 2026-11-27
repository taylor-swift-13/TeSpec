Require Import Goal.
Module Proofs.

Lemma proof_of_IntList_rev_precondition_wit_1 : Goal.IntList_rev_precondition_wit_1.
Proof.
  unfold Goal.IntList_rev_precondition_wit_1.
  exists (cons 2 (cons (-1) (@nil Z))), 8192.
Abort.

End Proofs.
