Require Import Coq.Reals.Reals.
Require Import Coq.Reals.Rbasic_fun.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.

Import ListNotations.
Open Scope Z_scope.

Definition sum_squares_spec (lst : list R) (result : Z) : Prop :=
  result = fold_right Z.add 0%Z (map (fun x : R => let c := up x in (c * c)%Z) lst).