
Require Import Coq.Arith.Arith.

Fixpoint fact (n : nat) : nat :=
  match n with
  | 0 => 1
  | S p => n * fact p
  end.

Fixpoint brazilian_factorial (n : nat) : nat :=
  match n with
  | 0 => 1
  | S p => fact n * brazilian_factorial p
  end.

Definition special_factorial_spec (n : nat) (ans : nat) : Prop :=
  ans = brazilian_factorial n.
