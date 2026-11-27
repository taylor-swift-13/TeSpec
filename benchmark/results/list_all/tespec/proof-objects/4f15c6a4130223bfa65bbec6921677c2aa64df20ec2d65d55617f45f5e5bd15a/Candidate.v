From SimpleC.Verification Require Import VCPrelude.
Require Import Goal input_def TeSpecLayout_6cc6801711812a8b23d954f7 FulminateMerge.
From Coq Require Import ZArith List Lia.
Import naive_C_Rules.
Import ListNotations.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma mergesort_singleton : forall a : Z, cn_mergesort [a] = [a].
Proof.
  intros a. rewrite cn_mergesort_equation. reflexivity.
Qed.

Lemma mergesort_zero_min :
  cn_mergesort [0; INT_MIN] = [INT_MIN; 0].
Proof.
  rewrite cn_mergesort_equation.
  change (cn_merge (cn_mergesort [0]) (cn_mergesort [INT_MIN]) = [INT_MIN; 0]).
  rewrite !mergesort_singleton.
  reflexivity.
Qed.

Lemma mergesort_max_zero_min :
  cn_mergesort [INT_MAX; 0; INT_MIN] = [INT_MIN; 0; INT_MAX].
Proof.
  rewrite cn_mergesort_equation.
  change (cn_merge (cn_mergesort [INT_MAX]) (cn_mergesort [0; INT_MIN]) = [INT_MIN; 0; INT_MAX]).
  rewrite mergesort_singleton, mergesort_zero_min.
  reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_1 : Goal.IntList_mergesort_entail_wit_1.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_1.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_2 : Goal.IntList_mergesort_entail_wit_2.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_2.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_3 : Goal.IntList_mergesort_entail_wit_3.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_3.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_4 : Goal.IntList_mergesort_entail_wit_4.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_4.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_5 : Goal.IntList_mergesort_entail_wit_5.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_5.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_6 : Goal.IntList_mergesort_entail_wit_6.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_6.
  right. intros. rewrite mergesort_singleton. entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_7 : Goal.IntList_mergesort_entail_wit_7.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_7.
  right. intros. rewrite mergesort_singleton. entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_8 : Goal.IntList_mergesort_entail_wit_8.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_8.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_9 : Goal.IntList_mergesort_entail_wit_9.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_9.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_10 : Goal.IntList_mergesort_entail_wit_10.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_10.
  right. intros. rewrite mergesort_zero_min. entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_11 : Goal.IntList_mergesort_entail_wit_11.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_11.
  right. intros. rewrite mergesort_singleton. entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_12 : Goal.IntList_mergesort_entail_wit_12.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_12.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_13 : Goal.IntList_mergesort_entail_wit_13.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_13.
  right. intros. entailer!; reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  right. intros. subst l___tespec_entry.
  rewrite mergesort_max_zero_min. entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof. Abort.

End Proofs.
