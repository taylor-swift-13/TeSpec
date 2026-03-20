
Require Import Coq.ZArith.ZArith.
Require Import Coq.ZArith.Znumtheory.

Open Scope Z_scope.

Definition x_or_y_spec (n x y res : Z) : Prop :=
  (prime n -> res = x) /\
  (~ prime n -> res = y).
