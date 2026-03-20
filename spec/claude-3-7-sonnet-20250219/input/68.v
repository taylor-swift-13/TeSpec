
Require Import List.
Import ListNotations.
Require Import Nat.

Definition is_even (n : nat) : Prop := Nat.even n = true.

Definition pluck_spec (arr : list nat) (result : list nat) : Prop :=
  (result = [] /\ (forall x, In x arr -> Nat.odd x = true)) \/
  (exists min_even idx,
      In min_even arr /\
      is_even min_even /\
      (forall x, In x arr -> is_even x -> min_even <= x) /\
      nth_error arr idx = Some min_even /\
      (forall j, nth_error arr j = Some min_even -> idx <= j) /\
      result = [min_even; idx]).
