Require Import ZArith.
Open Scope Z_scope.
Definition sum_to_n_spec (n : Z) (sum : Z) : Prop :=
sum = ((n + 1) * n) / 2.