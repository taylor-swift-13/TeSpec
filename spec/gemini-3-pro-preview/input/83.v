
Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.

Definition starts_one_ends_spec (n : Z) (result : Z) : Prop :=
  result = if Z.eq_dec n 1 then 1 else 18 * 10 ^ (n - 2).
