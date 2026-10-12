From Coq Require Import ZArith.
Local Open Scope Z_scope.
Definition least_root (n r : Z) : Prop :=
  0 <= r /\ forall k : Z, 0 <= k -> (r <= k <-> n <= k * k).
