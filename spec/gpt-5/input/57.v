Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Init.Nat.

Open Scope Z_scope.

Definition adj_le (l : list Z) : Prop :=
  forall i a b,
    nth_error l i = Some a ->
    nth_error l (S i) = Some b ->
    a <= b.

Definition adj_ge (l : list Z) : Prop :=
  forall i a b,
    nth_error l i = Some a ->
    nth_error l (S i) = Some b ->
    a >= b.

Definition monotonic_spec (l : list Z) (res : bool) : Prop :=
  res = true <-> adj_le l \/ adj_ge l.