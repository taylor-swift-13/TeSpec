Require Import Coq.Lists.List.
Require Import Coq.Init.Nat.

Import ListNotations.

Definition make_a_pile_spec (n : nat) (ans : list nat) : Prop :=
  ans = map (fun i => Nat.add n (Nat.mul 2 i)) (seq 0 n).