
Require Import ZArith.
Open Scope Z_scope.

Definition starts_one_ends_spec (n : Z) (count : Z) : Prop :=
  n > 0 /\
  (if Z.eqb n 1 then count = 1 else count = 18 * 10 ^ (n - 2)).
