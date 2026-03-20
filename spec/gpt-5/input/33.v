Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Sorting.Permutation.
Require Import Coq.ZArith.ZArith.

Definition third_indices (l : list Z) : list nat :=
  filter (fun i => Nat.eqb (Nat.modulo i 3) 0) (seq 0 (length l)).

Definition third_elems (l : list Z) : list Z :=
  map (fun i => nth i l 0%Z) (third_indices l).

Definition sort_third_spec (l : list Z) (l' : list Z) : Prop :=
  exists s',
    Sorted Z.le s' /\
    Permutation (third_elems l) s' /\
    length l' = length l /\
    (forall i, i < length l ->
      Nat.modulo i 3 <> 0 ->
      nth_error l' i = nth_error l i) /\
    (forall k, k < length (third_indices l) ->
      nth_error l' (nth k (third_indices l) 0) = nth_error s' k).