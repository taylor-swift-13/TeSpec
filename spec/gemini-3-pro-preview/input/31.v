
Require Import Coq.ZArith.ZArith.
Require Import Coq.ZArith.Znumtheory.
Open Scope Z_scope.

Definition is_prime_spec (n : Z) (result : bool) : Prop :=
  result = true <-> prime n.
