
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.
Import ListNotations.
Open Scope Z_scope.

Fixpoint count_set_bits_pos (p : positive) : nat :=
  match p with
  | xH => 1%nat
  | xO p' => count_set_bits_pos p'
  | xI p' => S (count_set_bits_pos p')
  end.

Definition count_set_bits (z : Z) : nat :=
  match z with
  | Z0 => 0%nat
  | Zpos p => count_set_bits_pos p
  | Zneg p => count_set_bits_pos p
  end.

Definition sort_criteria (x y : Z) : Prop :=
  let cx := count_set_bits x in
  let cy := count_set_bits y in
  (cx < cy)%nat \/ (cx = cy /\ x <= y).

Definition sort_array_spec (arr : list Z) (res : list Z) : Prop :=
  Permutation arr res /\ StronglySorted sort_criteria res.
