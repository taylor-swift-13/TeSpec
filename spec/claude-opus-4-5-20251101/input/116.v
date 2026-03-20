
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.

Open Scope Z_scope.

Fixpoint count_ones_pos (p : positive) : nat :=
  match p with
  | xH => 1%nat
  | xO p' => count_ones_pos p'
  | xI p' => S (count_ones_pos p')
  end.

Definition count_ones (z : Z) : nat :=
  match z with
  | Z0 => 0%nat
  | Zpos p => count_ones_pos p
  | Zneg p => count_ones_pos p
  end.

Definition cmp (x y : Z) : comparison :=
  let x1 := count_ones x in
  let y1 := count_ones y in
  match Nat.compare x1 y1 with
  | Eq => Z.compare x y
  | Lt => Lt
  | Gt => Gt
  end.

Definition le_by_cmp (x y : Z) : Prop :=
  match cmp x y with
  | Lt => True
  | Eq => True
  | Gt => False
  end.

Definition lt_by_cmp (x y : Z) : Prop :=
  match cmp x y with
  | Lt => True
  | _ => False
  end.

Definition sort_array_spec (arr result : list Z) : Prop :=
  Permutation arr result /\
  (forall i j, (i < j)%nat -> 
    forall x y, nth_error result i = Some x -> 
                nth_error result j = Some y -> 
                le_by_cmp x y).
