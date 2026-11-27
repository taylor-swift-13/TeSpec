From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros l xs_pre PreH1 PreH2 PreH3 PreH4.
  subst l.
  cbn [cn_split_snd cn_split_fst cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
  unfold Goal.IntList_split_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  pose proof (@ConAssertion.empty_state_is_empty naive_C_Rules.sts) as Hemp.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  cbn [sll].
  repeat first [exact Hemp | reflexivity | split].
Qed.

End Proofs.
