
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Sorted.
Import ListNotations.

Open Scope Z_scope.

Definition is_sorted_ascending (l : list Z) : Prop :=
  forall i j, (0 <= i < j)%nat -> (j < length l)%nat ->
    nth i l 0 <= nth j l 0.

Definition is_sorted_descending (l : list Z) : Prop :=
  forall i j, (0 <= i < j)%nat -> (j < length l)%nat ->
    nth i l 0 >= nth j l 0.

Definition is_permutation (l1 l2 : list Z) : Prop :=
  forall x, count_occ Z.eq_dec l1 x = count_occ Z.eq_dec l2 x.

Definition sort_array_spec (array : list Z) (result : list Z) : Prop :=
  match array with
  | [] => result = []
  | [x] => result = [x]
  | _ =>
    let first := hd 0 array in
    let last := last array 0 in
    is_permutation array result /\
    (if Z.even (first + last)
     then is_sorted_descending result
     else is_sorted_ascending result)
  end.
