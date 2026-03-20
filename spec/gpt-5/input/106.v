
Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Init.Nat.

Fixpoint factorial (n : nat) : nat :=
  match n with
  | 0 => 1
  | S k => (S k) * factorial k
  end.

Fixpoint sum_upto (n : nat) : nat :=
  match n with
  | 0 => 0
  | S k => sum_upto k + S k
  end.

Definition f_spec (n : nat) (ans : list nat) : Prop :=
  length ans = n /\
  forall i, 1 <= i <= n ->
    nth_error ans (i - 1) = Some (if Nat.even i then factorial i else sum_upto i).
