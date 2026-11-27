From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_acc_aux_precondition_wit_1 : Goal.IntList_length_acc_aux_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_acc_aux_precondition_wit_1.
  exists (cons INT_MAX (cons 0 (cons INT_MIN (@nil Z)))).
  exists UINT_MAX.
  exists 8192.
  exists 4096.
Abort.

End Proofs.
