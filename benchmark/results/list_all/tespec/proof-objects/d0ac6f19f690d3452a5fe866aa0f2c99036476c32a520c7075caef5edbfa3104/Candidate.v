From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_acc_aux_precondition_wit_1 : Goal.IntList_length_acc_aux_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_acc_aux_precondition_wit_1.
  exists (@nil Z), 0, 0, 4096.
Abort.

End Proofs.
