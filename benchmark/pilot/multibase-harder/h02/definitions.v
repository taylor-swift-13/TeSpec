Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Fixpoint sum_Z (xs : list Z) : Z :=
  match xs with
  | [] => 0
  | x :: rest => x + sum_Z rest
  end.

Definition Row4 (row : list Z) : Prop := length row = 4%nat.

Definition Rows3x4 (rows : list (list Z)) : Prop :=
  length rows = 3%nat /\ Forall Row4 rows.

Definition GridSummaryStep
  (old_rows : list (list Z)) (bias : Z)
  (new_rows : list (list Z)) (new_audit : list Z)
  (ret : Z) : Prop :=
  Rows3x4 old_rows /\
  Rows3x4 new_rows /\
  Forall2
    (fun old_row new_row =>
       sum_Z new_row = sum_Z old_row + 4 * bias)
    old_rows new_rows /\
  new_audit = map sum_Z old_rows /\
  ret = sum_Z (map sum_Z new_rows).
