From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_free_list_precondition_wit_1 : Goal.IntList_free_list_precondition_wit_1.
Proof.
  unfold Goal.IntList_free_list_precondition_wit_1.
  exists (@nil Z), 0%Z.
  intro H.
  eapply H.
  cbv.
  repeat first [reflexivity | split | intro].
Qed.

End Proofs.
