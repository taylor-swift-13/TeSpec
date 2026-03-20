
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.
Open Scope Z_scope.

Definition pluck_spec (arr : list Z) (res : list Z) : Prop :=
  ( (* Case 1: No even numbers exist in the array *)
    (forall x, In x arr -> Z.odd x = true) /\ res = []
  ) \/
  ( (* Case 2: Even numbers exist *)
    exists (v : Z) (i : Z),
      res = [v; i] /\
      (* The index i is within valid bounds *)
      0 <= i < Z.of_nat (length arr) /\
      (* The value v is located at index i *)
      nth_error arr (Z.to_nat i) = Some v /\
      (* The value is even *)
      Z.even v = true /\
      (* v is the smallest even value in the list *)
      (forall x, In x arr -> Z.even x = true -> v <= x) /\
      (* i is the smallest index among those containing the value v *)
      (* Since v is the minimum even, this implies no even number at j < i can be <= v *)
      (forall j x, 0 <= j < i -> nth_error arr (Z.to_nat j) = Some x -> Z.even x = true -> v < x)
  ).
