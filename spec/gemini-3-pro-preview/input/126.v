
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Sorting.Sorted.
Import ListNotations.

Definition is_sorted_spec (lst : list nat) (res : bool) : Prop :=
  res = true <-> 
  (Sorted le lst /\ (forall x : nat, count_occ Nat.eq_dec lst x <= 2)).
