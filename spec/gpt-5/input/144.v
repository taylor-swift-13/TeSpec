
Require Import Coq.Strings.String.
Require Import Coq.Arith.PeanoNat.
Require Import Coq.Init.Nat.
Require Import Coq.Bool.Bool.

Parameter parse_frac : string -> nat -> nat -> Prop.

Definition simplify_spec (x n : string) (res : bool) : Prop :=
  exists x1 x2 n1 n2 : nat,
    parse_frac x x1 x2 /\
    parse_frac n n1 n2 /\
    0 < x1 /\ 0 < x2 /\ 0 < n1 /\ 0 < n2 /\
    (res = true <-> Nat.modulo (x1 * n1) (x2 * n2) = 0).
