
Require Import Coq.Bool.Bool.
Require Import Coq.ZArith.ZArith.

Definition any_int_spec (x y z : Z) (result : bool) : Prop :=
  result = (if Z.eq_dec x (y + z) then true else false) ||
           (if Z.eq_dec y (x + z) then true else false) ||
           (if Z.eq_dec z (x + y) then true else false).
