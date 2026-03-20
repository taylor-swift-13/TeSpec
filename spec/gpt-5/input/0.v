
Require Import Coq.Reals.Reals.
Require Import Coq.Lists.List.
Require Import Coq.Arith.PeanoNat.

Open Scope R_scope.

Definition has_close_elements_spec (numbers : list R) (threshold : R) (result : bool) : Prop :=
  let P := exists i j x y,
    Nat.lt i j /\
    nth_error numbers i = Some x /\
    nth_error numbers j = Some y /\
    Rabs (x - y) < threshold in
  (result = true <-> P) /\ (result = false <-> ~ P).
