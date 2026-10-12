Require Import Coq.ZArith.ZArith.
Local Open Scope Z_scope.
Definition is_square (z : Z) : Prop := exists k : Z, z = k * k.
