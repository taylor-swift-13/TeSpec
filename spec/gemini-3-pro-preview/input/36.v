
Require Import Coq.ZArith.ZArith.
Require Import Coq.Arith.Arith.
Require Import Coq.Bool.Bool.

Open Scope Z_scope.

Fixpoint count_sevens_nat (n : nat) (fuel : nat) : Z :=
  match fuel with
  | O => 0
  | S f => 
    let is_7 := if (Nat.eqb (n mod 10) 7) then 1 else 0 in
    if (Nat.ltb n 10) then is_7
    else is_7 + count_sevens_nat (n / 10)%nat f
  end.

Definition count_sevens (z : Z) : Z :=
  let n := Z.to_nat z in
  count_sevens_nat n (S n).

Definition condition (i : Z) : bool :=
  (Z.eqb (i mod 11) 0) || (Z.eqb (i mod 13) 0).

Fixpoint fizz_buzz_sum (n : nat) : Z :=
  match n with
  | O => 0
  | S p => 
    let i := Z.of_nat p in
    let term := if condition i then count_sevens i else 0 in
    fizz_buzz_sum p + term
  end.

Definition fizz_buzz_spec (n : Z) (cnt : Z) : Prop :=
  cnt = fizz_buzz_sum (Z.to_nat n).
