From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal.
Require Import TeSpecLayout_da886d926b8d5f2795572f0a.
Require Import FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  left.
  intros l xs Hxs Hxs' Hl.
  subst l.
  rewrite cn_mergesort_equation.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
  unfold Goal.IntList_mergesort_precondition_wit_1.
  exists (@nil Z), 0.
  intro H.
  apply (H (@ConAssertion.empty_state naive_C_Rules.sts)).
  cbn [sll].
  repeat first
    [ exact (@ConAssertion.empty_state_is_empty naive_C_Rules.sts)
    | reflexivity
    | split ].
Qed.

End Proofs.
