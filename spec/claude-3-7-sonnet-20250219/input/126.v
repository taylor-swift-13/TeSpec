
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.
Require Import Coq.Sorting.Sorted.
Import ListNotations.

Definition no_more_than_two_duplicates (lst : list nat) : Prop :=
  forall x : nat, count_occ Nat.eq_dec lst x <= 2.

Definition ascending_sorted (lst : list nat) : Prop :=
  Sorted Nat.le lst.

Definition is_sorted_spec (lst : list nat) (b : bool) : Prop :=
  b = true <-> (no_more_than_two_duplicates lst /\ ascending_sorted lst).
