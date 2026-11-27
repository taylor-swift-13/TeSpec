From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import SimpleC.EE.QCP_demos_human.sll_lib.
Require Import FulminateMerge.
Require Import Goal.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  left.
  intros l xs H1 H2 H3.
  subst l.
  rewrite cn_mergesort_equation.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
  unfold Goal.IntList_mergesort_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  pose proof (@ConAssertion.empty_state_is_empty naive_C_Rules.sts) as Hemp.
  specialize (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  apply H.
  simpl sll.
  repeat first [exact Hemp | reflexivity | split].
Qed.

End Proofs.
