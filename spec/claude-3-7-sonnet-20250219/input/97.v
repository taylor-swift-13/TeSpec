
Require Import ZArith.
Open Scope Z_scope.

Definition multiply_spec (a b : Z) (res : Z) : Prop :=
  let unit_digit_a := Z.abs a mod 10 in
  let unit_digit_b := Z.abs b mod 10 in
  res = unit_digit_a * unit_digit_b.
