Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Arith.PeanoNat.

Fixpoint sum_squares_aux (i : nat) (lst : list Z) : Z :=
  match lst with
  | nil => 0%Z
  | x :: xs =>
      let term :=
        if Nat.eqb (Nat.modulo i 3) 0 then (x * x)%Z
        else if Nat.eqb (Nat.modulo i 4) 0 then ((x * x)%Z * x)%Z
        else x
      in (term + sum_squares_aux (S i) xs)%Z
  end.

Definition sum_squares_spec (lst : list Z) (ans : Z) : Prop :=
  ans = sum_squares_aux 0 lst.