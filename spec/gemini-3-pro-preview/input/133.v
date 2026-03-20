
Require Import Coq.Reals.Reals.
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.

Definition sum_squares_spec (lst : list R) (res : Z) : Prop :=
  res = fold_right Z.add 0%Z (map (fun x => let ceil_x := up x in Z.mul ceil_x ceil_x) lst).
