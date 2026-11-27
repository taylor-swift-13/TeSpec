From SimpleC.Verification Require Import VCPrelude.
Require Import Goal input_def TeSpecLayout_6cc6801711812a8b23d954f7 FulminateMerge.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

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
  rewrite cn_mergesort_equation.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_4 : Goal.IntList_mergesort_entail_wit_4.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_4.
  right; intros.
  rewrite cn_mergesort_equation.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_5 : Goal.IntList_mergesort_entail_wit_5.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_5.
  right; intros.
  cbn [cn_split_snd cn_split_fst cn_split].
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_6 : Goal.IntList_mergesort_entail_wit_6.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_6.
  right; intros.
  cbn [cn_split_snd cn_split_fst cn_split].
  entailer!.
Qed.

Lemma sorted_two :
  cn_mergesort (cons 2 (cons (-1) nil)) = cons (-1) (cons 2 nil).
Proof.
  rewrite cn_mergesort_equation.
  cbn [cn_split_fst cn_split_snd cn_split].
  rewrite !cn_mergesort_equation.
  reflexivity.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  right; intros.
  subst l___tespec_entry.
  rewrite sorted_two.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
Abort.

End Proofs.
