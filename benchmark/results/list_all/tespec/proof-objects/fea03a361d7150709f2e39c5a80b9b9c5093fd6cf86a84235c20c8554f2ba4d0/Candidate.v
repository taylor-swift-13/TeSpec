From SimpleC.Verification Require Import VCPrelude.
Require Import Goal FulminateMerge.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma mergesort_singleton (a : Z) :
  cn_mergesort (cons a nil) = cons a nil.
Proof.
  rewrite cn_mergesort_equation.
  reflexivity.
Qed.

Lemma mergesort_entry :
  cn_mergesort (cons 2 (cons (-1) nil)) =
  cons (-1) (cons 2 nil).
Proof.
  rewrite cn_mergesort_equation.
  change (cn_merge (cn_mergesort (cons 2 nil))
                   (cn_mergesort (cons (-1) nil)) =
          cons (-1) (cons 2 nil)).
  rewrite !mergesort_singleton.
  reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_1 : Goal.IntList_mergesort_entail_wit_1.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_1.
  right; intros.
  cbn [cn_merge].
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_2 : Goal.IntList_mergesort_entail_wit_2.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_2.
  right; intros.
  cbn [cn_merge].
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_3 : Goal.IntList_mergesort_entail_wit_3.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_3.
  right; intros.
  rewrite mergesort_singleton.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_4 : Goal.IntList_mergesort_entail_wit_4.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_4.
  right; intros.
  rewrite mergesort_singleton.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_5 : Goal.IntList_mergesort_entail_wit_5.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_5.
  right; intros.
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_6 : Goal.IntList_mergesort_entail_wit_6.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_6.
  right; intros.
  cbn [cn_split_fst cn_split_snd cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  right; intros.
  subst l___tespec_entry.
  rewrite mergesort_entry.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_2 : Goal.IntList_mergesort_return_wit_2.
Proof. Abort.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof. Abort.

End Proofs.
