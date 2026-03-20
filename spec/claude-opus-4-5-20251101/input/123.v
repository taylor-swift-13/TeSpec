
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.

Open Scope Z_scope.

Definition collatz_next (x : Z) : Z :=
  if Z.even x then x / 2 else x * 3 + 1.

Inductive collatz_sequence : Z -> list Z -> Prop :=
  | collatz_one : collatz_sequence 1 (1 :: nil)
  | collatz_step : forall x seq,
      x > 1 ->
      collatz_sequence (collatz_next x) seq ->
      collatz_sequence x (x :: seq).

Definition is_odd (x : Z) : bool := Z.odd x.

Definition filter_odds (l : list Z) : list Z :=
  filter is_odd l.

Inductive sorted_ascending : list Z -> Prop :=
  | sorted_nil : sorted_ascending nil
  | sorted_single : forall x, sorted_ascending (x :: nil)
  | sorted_cons : forall x y l,
      x <= y ->
      sorted_ascending (y :: l) ->
      sorted_ascending (x :: y :: l).

Definition is_permutation (l1 l2 : list Z) : Prop :=
  forall x, count_occ Z.eq_dec l1 x = count_occ Z.eq_dec l2 x.

Definition get_odd_collatz_spec (n : Z) (result : list Z) : Prop :=
  n > 0 /\
  exists collatz_seq : list Z,
    collatz_sequence n collatz_seq /\
    exists odds : list Z,
      odds = filter_odds collatz_seq /\
      is_permutation odds result /\
      sorted_ascending result.
