
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.
Open Scope Z_scope.

Definition compare_spec (game guess result : list Z) : Prop :=
  length game = length guess /\
  length result = length game /\
  (forall i : nat, (i < length game)%nat ->
    nth i result 0 = Z.abs (nth i game 0 - nth i guess 0)).
