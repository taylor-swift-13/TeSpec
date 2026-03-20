
Require Import Coq.Lists.List.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Reals.Reals.
Require Import Coq.ZArith.ZArith.
Import ListNotations.

Open Scope R_scope.

Definition is_sorted (l : list R) : Prop :=
  forall i j, (i < j < length l)%nat -> nth i l 0 <= nth j l 0.

Definition median_spec (l : list R) (result : R) : Prop :=
  l <> [] /\
  exists sorted_l : list R,
    Permutation l sorted_l /\
    is_sorted sorted_l /\
    length sorted_l = length l /\
    ((Nat.odd (length l) = true /\
      result = nth (length l / 2) sorted_l 0) \/
     (Nat.even (length l) = true /\
      result = (nth (length l / 2 - 1) sorted_l 0 + nth (length l / 2) sorted_l 0) / 2)).
