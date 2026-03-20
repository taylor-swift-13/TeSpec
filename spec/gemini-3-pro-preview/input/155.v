
Require Import Coq.ZArith.ZArith.
Require Import Coq.Init.Nat.

Inductive digit_counts : Z -> nat -> nat -> Prop :=
| dc_base : forall n, (0 <= n < 10)%Z ->
    digit_counts n (if Z.even n then 1 else 0) (if Z.even n then 0 else 1)
| dc_step : forall n e o, (n >= 10)%Z ->
    digit_counts (Z.div n 10) e o ->
    digit_counts n (e + (if Z.even (Z.modulo n 10) then 1 else 0))
                   (o + (if Z.even (Z.modulo n 10) then 0 else 1)).

Definition even_odd_count_spec (num : Z) (res : nat * nat) : Prop :=
  let (even, odd) := res in
  digit_counts (Z.abs num) even odd.
