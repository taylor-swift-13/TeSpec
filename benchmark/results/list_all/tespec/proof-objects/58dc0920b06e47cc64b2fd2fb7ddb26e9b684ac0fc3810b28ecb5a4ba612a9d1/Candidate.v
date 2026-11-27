From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros l xs H1 H2 H3 H4.
  subst l.
  unfold cn_split_snd, cn_split_fst.
  simpl cn_split.
  simpl snd.
  simpl fst.
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
  unfold Goal.IntList_split_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  cbv in H.
  eapply H.
  repeat split; reflexivity.
Qed.

End Proofs.
