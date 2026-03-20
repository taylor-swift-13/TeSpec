
Require Import Coq.Init.Nat.

Fixpoint fact (n : nat) : nat :=
  match n with
  | 0 => 1
  | S k => Nat.mul n (fact k)
  end.

Fixpoint brazilian_factorial (n : nat) : nat :=
  match n with
  | 0 => 1
  | S k => Nat.mul (fact n) (brazilian_factorial k)
  end.

Definition special_factorial_spec (n : nat) (ans : nat) : Prop :=
  ans = brazilian_factorial n.
