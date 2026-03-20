Require Import Coq.Strings.String.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Bool.Bool.

Fixpoint has_divisor_upto (n k : nat) : bool :=
  match k with
  | 0 => false
  | 1 => false
  | S k' => orb (Nat.eqb (Nat.modulo n (S k')) 0) (has_divisor_upto n k')
  end.

Definition is_primeb (a : nat) : bool :=
  negb (orb (Nat.ltb a 2) (has_divisor_upto a (Nat.pred a))).

Definition prime_length_spec (s : string) (b : bool) : Prop :=
  b = is_primeb (String.length s).