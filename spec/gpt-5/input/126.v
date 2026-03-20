
Require Import Coq.Lists.List.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Arith.PeanoNat.

Definition is_sorted_spec (lst : list nat) (res : bool) : Prop :=
  res = true <-> Sorted le lst /\ (forall x : nat, le (count_occ Nat.eq_dec lst x) 2).
