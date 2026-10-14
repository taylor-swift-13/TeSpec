From Coq Require Import ZArith List Sorting.Permutation Sorting.Sorted.
Require Import FiniteMultiset merge_sorted_arrays.
Theorem merge_contract_correspondence a b out :
  StronglySorted Z.le a -> StronglySorted Z.le b ->
  (out = merge_sorted_arrays_spec a b <->
   finite_counts (a ++ b) out /\ StronglySorted Z.le out).
Proof.
  intros Ha Hb; split.
  - intros ->; split.
    + apply finite_counts_iff_permutation, Permutation_sym.
      apply merge_sorted_arrays_permutation.
    + now apply merge_sorted_arrays_sorted.
  - intros [Hcounts Hsort]. apply sorted_permutation_unique.
    + exact Hsort.
    + now apply merge_sorted_arrays_sorted.
    + apply finite_counts_iff_permutation in Hcounts.
      eapply Permutation_trans; [apply Permutation_sym; exact Hcounts|].
      apply Permutation_sym, merge_sorted_arrays_permutation.
Qed.
Print Assumptions merge_contract_correspondence.
