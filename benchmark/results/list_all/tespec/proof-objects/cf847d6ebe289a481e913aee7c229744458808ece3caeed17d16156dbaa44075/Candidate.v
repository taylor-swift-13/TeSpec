From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_6cc6801711812a8b23d954f7.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_split_return_wit_1 : Goal.IntList_split_return_wit_1.
Proof.
  unfold Goal.IntList_split_return_wit_1.
  right.
  intros l___tespec_entry xs_pre PreH1 PreH2 PreH3 PreH4.
  subst l___tespec_entry.
  cbn [cn_split_snd cn_split_fst cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_split_precondition_wit_1 : Goal.IntList_split_precondition_wit_1.
Proof.
  unfold Goal.IntList_split_precondition_wit_1.
  exists (@nil Z), 0.
  assert (Hp : emp |--
    “ (0 = 0) ” &&
    “ ((@nil Z) = (@nil Z)) ” &&
    sll 0 (@nil Z)).
  {
    simpl sll.
    entailer!.
  }
  intro H.
  exact (H (@ConAssertion.empty_state naive_C_Rules.sts)
    (Hp (@ConAssertion.empty_state naive_C_Rules.sts)
      (@ConAssertion.empty_state_is_empty naive_C_Rules.sts))).
Qed.

End Proofs.
