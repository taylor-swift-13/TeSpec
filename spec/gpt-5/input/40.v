Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.

Open Scope Z_scope.

Definition triples_sum_to_zero_spec (l : list Z) (res : bool) : Prop :=
  (res = true <-> exists (i j k : nat) (xi xj xk : Z),
    i <> j /\ i <> k /\ j <> k /\
    nth_error l i = Some xi /\
    nth_error l j = Some xj /\
    nth_error l k = Some xk /\
    xi + xj + xk = 0%Z) /\
  (res = false <-> forall (i j k : nat) (xi xj xk : Z),
    i <> j /\ i <> k /\ j <> k /\
    nth_error l i = Some xi /\
    nth_error l j = Some xj /\
    nth_error l k = Some xk ->
    xi + xj + xk <> 0%Z).