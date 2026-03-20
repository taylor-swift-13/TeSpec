
Require Import ZArith.
Open Scope Z_scope.

Definition largest_divisor_spec (n d : Z) : Prop :=
  1 < n ->
  1 < d < n /\
  n mod d = 0 /\
  (forall k, 1 < k < n -> n mod k = 0 -> d <= k).
