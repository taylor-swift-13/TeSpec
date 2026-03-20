
Require Import Coq.Reals.Reals.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.
Open Scope R_scope.

Definition find_closest_elements_spec (numbers : list R) (result : R * R) : Prop :=
  let (a, b) := result in
  (length numbers >= 2)%nat ->
  a <= b /\
  (exists i j : nat, i <> j /\ nth_error numbers i = Some a /\ nth_error numbers j = Some b) /\
  (forall i j : nat, forall x y : R,
    i <> j ->
    nth_error numbers i = Some x ->
    nth_error numbers j = Some y ->
    b - a <= Rabs (x - y)).
