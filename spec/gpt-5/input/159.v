Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.

Import ListNotations.
Open Scope Z_scope.

Definition eat_spec (number need remaining : Z) (res : list Z) : Prop :=
  0 <= number /\ number <= 1000 /\
  0 <= need /\ need <= 1000 /\
  0 <= remaining /\ remaining <= 1000 /\
  res =
    (if Z.leb need remaining
     then [number + need; remaining - need]
     else [number + remaining; 0]).