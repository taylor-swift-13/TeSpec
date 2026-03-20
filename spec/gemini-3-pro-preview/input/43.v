
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition pairs_sum_to_zero_spec (l : list Z) (res : bool) : Prop :=
  res = true <-> 
  (exists (i j : nat) (vi vj : Z), 
    nth_error l i = Some vi /\ 
    nth_error l j = Some vj /\ 
    i <> j /\ 
    vi + vj = 0).
