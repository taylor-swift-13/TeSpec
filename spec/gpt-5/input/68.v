Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Arith.PeanoNat.

Definition pluck_spec (arr : list Z) (res : list Z) : Prop :=
((forall x, In x arr -> Z.even x = false) /\ res = nil) \/
(exists min_even i,
  Z.even min_even = true /\
  In min_even arr /\
  (forall y, In y arr -> Z.even y = true -> Z.le min_even y) /\
  nth_error arr i = Some min_even /\
  (forall j, Nat.lt j i -> nth_error arr j <> Some min_even) /\
  res = min_even :: Z.of_nat i :: nil).