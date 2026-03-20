
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Definition make_a_pile_spec (n : nat) (res : list nat) : Prop :=
  n > 0 /\
  length res = n /\
  (forall i, i < n -> nth i res 0 = n + 2 * i).
