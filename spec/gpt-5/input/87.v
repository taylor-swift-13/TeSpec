Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.

Definition row (p : nat * nat) : nat := fst p.
Definition col (p : nat * nat) : nat := snd p.

Definition pair_order (p1 p2 : nat * nat) : Prop :=
  row p1 < row p2 \/ (row p1 = row p2 /\ col p1 > col p2).

Definition match_pos (lst : list (list Z)) (x : Z) (i j : nat) : Prop :=
  match nth_error lst i with
  | Some r =>
      match nth_error r j with
      | Some v => v = x
      | None => False
      end
  | None => False
  end.

Definition get_row_spec (lst : list (list Z)) (x : Z) (res : list (nat * nat)) : Prop :=
  NoDup res /\
  StronglySorted pair_order res /\
  forall i j, In (i, j) res <-> match_pos lst x i j.