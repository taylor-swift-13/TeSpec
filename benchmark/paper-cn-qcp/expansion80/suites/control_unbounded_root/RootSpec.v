Require Import Coq.ZArith.ZArith.
Open Scope Z_scope.
Definition least_root (x r:Z) : Prop := 0 <= r /\ forall k:Z, 0 <= k -> (r <= k <-> x <= k*k).
