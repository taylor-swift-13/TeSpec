Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Require Import Coq.Init.Nat.

Definition divides (d n : nat) : Prop :=
  exists k, n = Nat.mul d k.

Definition prime (p : nat) : Prop :=
  2 <= p /\ forall d, 2 <= d /\ d < p -> ~ divides d p.

Definition count_up_to_spec (n : nat) (ans : list nat) : Prop :=
  NoDup ans /\
  forall p, In p ans <-> prime p /\ p < n.