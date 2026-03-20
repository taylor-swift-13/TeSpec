
Require Import List.
Require Import ZArith.
Import ListNotations.

Definition coord := (nat * nat)%type.

Fixpoint find_in_row_desc (row : list Z) (x : Z) (row_idx : nat) (col_idx : nat) : list coord :=
  match row with
  | [] => []
  | h :: t =>
    let rest := find_in_row_desc t x row_idx (S col_idx) in
    if Z.eqb h x then rest ++ [(row_idx, col_idx)] else rest
  end.

Fixpoint get_row_helper (lst : list (list Z)) (x : Z) (row_idx : nat) : list coord :=
  match lst with
  | [] => []
  | row :: rest =>
    find_in_row_desc row x row_idx 0 ++ get_row_helper rest x (S row_idx)
  end.

Definition get_row_spec (lst : list (list Z)) (x : Z) (result : list coord) : Prop :=
  result = get_row_helper lst x 0 /\
  (forall p, In p result -> 
    exists row, nth_error lst (fst p) = Some row /\ 
                nth_error row (snd p) = Some x) /\
  (forall i j, 
    match nth_error lst i with
    | Some row => 
      match nth_error row j with
      | Some v => v = x -> In (i, j) result
      | None => True
      end
    | None => True
    end) /\
  (forall i1 j1 i2 j2 idx1 idx2,
    nth_error result idx1 = Some (i1, j1) ->
    nth_error result idx2 = Some (i2, j2) ->
    idx1 < idx2 ->
    (i1 < i2 \/ (i1 = i2 /\ j1 > j2))).
