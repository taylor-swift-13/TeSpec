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
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
  unfold Goal.IntList_split_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  assert (Hsat : exists h, emp h).
  { eexists; reflexivity. }
  destruct Hsat as [h Hemp].
  apply (H h).
  cbn [sll].
  repeat split; try reflexivity; exact Hemp.
Qed.

End Proofs.
