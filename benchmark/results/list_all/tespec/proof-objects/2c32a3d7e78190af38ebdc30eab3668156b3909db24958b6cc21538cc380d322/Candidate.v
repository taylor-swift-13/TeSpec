From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_acc_aux_precondition_wit_1 : Goal.IntList_length_acc_aux_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_acc_aux_precondition_wit_1.
  exists (cons (1%Z) (@nil Z)), (1%Z), (8192%Z), (4096%Z).
Abort.

End Proofs.
