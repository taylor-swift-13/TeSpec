
Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Definition make_a_pile_spec (n : nat) (pile : list nat) : Prop :=
  length pile = n /\
  forall i, i < n -> nth i pile 0 = n + 2 * i.
