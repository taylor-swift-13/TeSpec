
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition make_a_pile_spec (n : Z) (res : list Z) : Prop :=
  res = map (fun i => n + 2 * Z.of_nat i) (seq 0 (Z.to_nat n)).
