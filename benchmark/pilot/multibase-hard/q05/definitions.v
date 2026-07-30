Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.

Definition EvenReturn (value : Z) : Prop :=
  exists k : Z, value = 2 * k.
