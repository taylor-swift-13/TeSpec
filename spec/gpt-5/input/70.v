
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.

Import ListNotations.

Definition index_strange (n k : nat) : nat :=
  if Nat.even k then Nat.div2 k else n - 1 - Nat.div2 k.

Definition ans_of_sorted (s ans : list Z) : Prop :=
  length ans = length s /\
  forall k, k < length s ->
    nth_error ans k = nth_error s (index_strange (length s) k).

Definition strange_sort_list_spec (lst ans : list Z) : Prop :=
  exists s,
    Permutation s lst /\
    Sorted Z.le s /\
    ans_of_sorted s ans.
