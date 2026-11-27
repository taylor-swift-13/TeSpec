From SimpleC.Verification Require Import VCPrelude.
Require Import Goal FulminateMerge.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Ltac solve_concrete_branch :=
  right; intros; subst;
  entailer!;
  first [ assumption
        | (repeat rewrite cn_mergesort_equation; reflexivity)
        | lia ].

Lemma proof_of_IntList_mergesort_entail_wit_1 : Goal.IntList_mergesort_entail_wit_1.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_1.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_2 : Goal.IntList_mergesort_entail_wit_2.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_2.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_3 : Goal.IntList_mergesort_entail_wit_3.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_3.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_4 : Goal.IntList_mergesort_entail_wit_4.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_4.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_5 : Goal.IntList_mergesort_entail_wit_5.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_5.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_6 : Goal.IntList_mergesort_entail_wit_6.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_6.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_7 : Goal.IntList_mergesort_entail_wit_7.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_7.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_8 : Goal.IntList_mergesort_entail_wit_8.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_8.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_9 : Goal.IntList_mergesort_entail_wit_9.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_9.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_10 : Goal.IntList_mergesort_entail_wit_10.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_10.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_11 : Goal.IntList_mergesort_entail_wit_11.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_11.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_12 : Goal.IntList_mergesort_entail_wit_12.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_12.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_entail_wit_13 : Goal.IntList_mergesort_entail_wit_13.
Proof.
  unfold Goal.IntList_mergesort_entail_wit_13.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  solve_concrete_branch.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
Abort.

End Proofs.
