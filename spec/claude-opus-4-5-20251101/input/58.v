
Require Import List.
Require Import ZArith.
Import ListNotations.

Definition is_sorted (l : list Z) : Prop :=
  forall i j, (0 <= i < j)%nat -> (j < length l)%nat ->
    (Z.le (nth i l 0%Z) (nth j l 0%Z)).

Definition no_duplicates {A : Type} (l : list A) : Prop :=
  NoDup l.

Definition is_intersection {A : Type} (l1 l2 result : list A) : Prop :=
  forall x, In x result <-> (In x l1 /\ In x l2).

Definition common_spec (l1 l2 result : list Z) : Prop :=
  is_intersection l1 l2 result /\
  no_duplicates result /\
  is_sorted result.
