
Require Import List.
Require Import ZArith.
Require Import Lia.

Open Scope Z_scope.

Definition is_valid_grid (grid : list (list Z)) (N : Z) : Prop :=
  N >= 2 /\
  Z.of_nat (length grid) = N /\
  (forall row, In row grid -> Z.of_nat (length row) = N) /\
  (forall v, 1 <= v <= N * N -> 
    exists i j, 0 <= i < N /\ 0 <= j < N /\
    nth (Z.to_nat j) (nth (Z.to_nat i) grid nil) 0 = v).

Definition get_cell (grid : list (list Z)) (i j : Z) : Z :=
  nth (Z.to_nat j) (nth (Z.to_nat i) grid nil) 0.

Definition is_neighbor (N i1 j1 i2 j2 : Z) : Prop :=
  0 <= i1 < N /\ 0 <= j1 < N /\
  0 <= i2 < N /\ 0 <= j2 < N /\
  ((i1 = i2 /\ (j2 = j1 + 1 \/ j2 = j1 - 1)) \/
   (j1 = j2 /\ (i2 = i1 + 1 \/ i2 = i1 - 1))).

Definition find_one_pos (grid : list (list Z)) (N : Z) (x y : Z) : Prop :=
  0 <= x < N /\ 0 <= y < N /\ get_cell grid x y = 1.

Definition min_neighbor_value (grid : list (list Z)) (N x y : Z) (mn : Z) : Prop :=
  (exists i j, is_neighbor N x y i j /\ get_cell grid i j = mn) /\
  (forall i j, is_neighbor N x y i j -> mn <= get_cell grid i j).

Definition minPath_spec (grid : list (list Z)) (k : Z) (result : list Z) : Prop :=
  let N := Z.of_nat (length grid) in
  is_valid_grid grid N ->
  k >= 1 ->
  exists x y mn,
    find_one_pos grid N x y /\
    min_neighbor_value grid N x y mn /\
    Z.of_nat (length result) = k /\
    (forall idx, 0 <= idx < k ->
      nth (Z.to_nat idx) result 0 = (if (idx mod 2 =? 0) then 1 else mn)).
