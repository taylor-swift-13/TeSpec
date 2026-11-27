From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Require Import Goal FulminateMerge.
Local Open Scope sac.
Local Open Scope Z_scope.

Module Proofs.

Lemma proof_of_IntList_mergesort_return_wit_1 : Goal.IntList_mergesort_return_wit_1.
Proof.
  unfold Goal.IntList_mergesort_return_wit_1.
  left.
  intros.
  subst l___tespec_entry.
  rewrite <- cn_mergesort_split.
  entailer!.
Qed.

Lemma proof_of_IntList_mergesort_precondition_wit_1 : Goal.IntList_mergesort_precondition_wit_1.
Proof.
Abort.

End Proofs.
