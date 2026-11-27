From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_length_precondition_wit_1 : Goal.IntList_length_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  hnf in H.
  eapply H.
  simpl sll.
  repeat first [split | intro]; reflexivity.
Qed.

End Proofs.
