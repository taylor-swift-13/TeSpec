
Require Import Coq.Reals.Reals.
Require Import Coq.ZArith.ZArith.
Open Scope R_scope.

Definition truncate_number_spec (number : R) (result : R) : Prop :=
  number >= 0 ->
  exists i : Z, IZR i <= number < IZR i + 1 /\ result = number - IZR i.
