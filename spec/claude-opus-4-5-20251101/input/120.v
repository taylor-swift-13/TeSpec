
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.
Import ListNotations.

Open Scope Z_scope.

Definition is_sorted (l : list Z) : Prop :=
  forall i j, (0 <= i < j)%nat -> (j < length l)%nat ->
    match nth_error l i, nth_error l j with
    | Some a, Some b => a <= b
    | _, _ => True
    end.

Definition count_occ_Z (l : list Z) (x : Z) : nat :=
  count_occ Z.eq_dec l x.

Definition is_permutation_of_sublist (result original : list Z) : Prop :=
  forall x, (count_occ_Z result x <= count_occ_Z original x)%nat.

Definition are_top_k_elements (result original : list Z) (k : nat) : Prop :=
  forall x y,
    In x result ->
    In y original ->
    ~In y result ->
    count_occ_Z result y = 0%nat ->
    x >= y.

Definition maximum_spec (arr : list Z) (k : nat) (result : list Z) : Prop :=
  length result = k /\
  is_sorted result /\
  is_permutation_of_sublist result arr /\
  (k <= length arr)%nat /\
  (forall x, In x result -> In x arr) /\
  (forall dropped, 
    In dropped arr -> 
    (count_occ_Z arr dropped > count_occ_Z result dropped)%nat ->
    forall kept, In kept result -> kept >= dropped).
