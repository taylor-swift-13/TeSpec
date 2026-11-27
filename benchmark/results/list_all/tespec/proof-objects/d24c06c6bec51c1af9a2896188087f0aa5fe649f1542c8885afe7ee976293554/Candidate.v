From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import Goal.

Module Proofs.

Lemma proof_of_IntList_length_precondition_wit_1 : Goal.IntList_length_precondition_wit_1.
Proof.
  unfold Goal.IntList_length_precondition_wit_1.
  exists (@nil Z), 0%Z.
  intro H.
  cbv in H.
  eapply H; cbv; repeat split; try reflexivity.
  Unshelve.
  all: repeat first [exact tt | exact 0%Z | exact O | exact I | exact None | exact nil | progress intros | constructor].
Qed.

End Proofs.
