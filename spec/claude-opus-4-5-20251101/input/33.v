
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.
Import ListNotations.

Fixpoint get_indices_div_by_three (l : list nat) (idx : nat) : list nat :=
  match l with
  | [] => []
  | x :: xs => if Nat.eqb (Nat.modulo idx 3) 0 
               then x :: get_indices_div_by_three xs (S idx)
               else get_indices_div_by_three xs (S idx)
  end.

Fixpoint nth_default (d : nat) (l : list nat) (n : nat) : nat :=
  match l, n with
  | [], _ => d
  | x :: _, 0 => x
  | _ :: xs, S n' => nth_default d xs n'
  end.

Fixpoint build_result (l : list nat) (sorted_thirds : list nat) (idx : nat) : list nat :=
  match l with
  | [] => []
  | x :: xs => if Nat.eqb (Nat.modulo idx 3) 0
               then nth_default 0 sorted_thirds (idx / 3) :: build_result xs sorted_thirds (S idx)
               else x :: build_result xs sorted_thirds (S idx)
  end.

Definition is_sorted (l : list nat) : Prop :=
  forall i j, i < j -> j < length l -> nth_default 0 l i <= nth_default 0 l j.

Definition sort_third_spec (l : list nat) (l' : list nat) : Prop :=
  let thirds := get_indices_div_by_three l 0 in
  exists sorted_thirds : list nat,
    Permutation thirds sorted_thirds /\
    is_sorted sorted_thirds /\
    length l = length l' /\
    (forall i, i < length l ->
      if Nat.eqb (Nat.modulo i 3) 0
      then nth_default 0 l' i = nth_default 0 sorted_thirds (i / 3)
      else nth_default 0 l' i = nth_default 0 l i).
