
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition search_spec (lst : list Z) (ans : Z) : Prop :=
  let count (x : Z) := Z.of_nat (count_occ Z.eq_dec lst x) in
  let is_valid (x : Z) := x > 0 /\ count x >= x in
  (is_valid ans /\ (forall x, is_valid x -> x <= ans)) \/
  (ans = -1 /\ (forall x, ~ is_valid x)).
