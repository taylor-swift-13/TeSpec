From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_free_list_precondition_wit_1 : Goal.IntList_free_list_precondition_wit_1.
Proof.
  unfold Goal.IntList_free_list_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  simpl in H.
  eapply H.
  repeat first [reflexivity | split | intro].
Qed.

End Proofs.
