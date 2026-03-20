
Require Import Coq.Reals.Reals.
Open Scope R_scope.

Definition triangle_area_spec (a h : R) (res : R) : Prop :=
  res = a * h / 2.
