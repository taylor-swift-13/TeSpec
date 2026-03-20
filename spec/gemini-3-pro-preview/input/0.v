
Require Import Coq.Reals.Reals.
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.
Open Scope R_scope.

Definition has_close_elements_spec (numbers : list R) (threshold : R) (result : bool) : Prop :=
  result = true <->
  exists (i j : nat),
    (i < length numbers)%nat /\
    (j < length numbers)%nat /\
    i <> j /\
    Rabs (nth i numbers 0 - nth j numbers 0) < threshold.
