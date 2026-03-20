
Require Import ZArith.
Require Import Lia.

Open Scope Z_scope.

Definition starts_one_ends_spec (n : Z) (result : Z) : Prop :=
  n > 0 /\
  ((n = 1 /\ result = 1) \/
   (n > 1 /\ result = 18 * 10 ^ (n - 2))).
