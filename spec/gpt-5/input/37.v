Require Import Coq.Lists.List.
Import ListNotations.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Arith.PeanoNat.

Fixpoint evens_list (l : list Z) : list Z :=
  match l with
  | [] => []
  | x :: [] => [x]
  | x :: _ :: t => x :: evens_list t
  end.

Definition sort_even_spec (l : list Z) (l' : list Z) : Prop :=
  exists es,
    Sorted Z.le es /\
    Permutation es (evens_list l) /\
    length l' = length l /\
    forall i, i < length l ->
      (if Nat.even i
       then nth i l' 0%Z = nth (Nat.div2 i) es 0%Z
       else nth i l' 0%Z = nth i l 0%Z).