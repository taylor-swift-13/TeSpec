From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_copy_precondition_wit_1 : Goal.IntList_copy_precondition_wit_1.
Proof.
  unfold Goal.IntList_copy_precondition_wit_1.
  exists (@nil Z).
  exists 0%Z.
  intro H.
  eapply H.
  cbv.
  repeat first [intro | split | reflexivity].
Qed.

End Proofs.
