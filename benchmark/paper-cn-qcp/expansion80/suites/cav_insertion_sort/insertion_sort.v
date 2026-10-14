From Coq Require Import ZArith List Sorting.Permutation Sorting.Sorted.
Definition insertion_sort_spec (input output : list Z) : Prop :=
  Permutation input output /\ StronglySorted Z.le output.
