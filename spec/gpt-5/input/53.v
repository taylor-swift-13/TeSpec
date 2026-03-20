Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.
Definition add_spec (x : Z) (y : Z) (r : Z) : Prop :=
  r = x + y.