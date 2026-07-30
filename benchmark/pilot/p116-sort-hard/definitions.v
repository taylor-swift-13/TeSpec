Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Permutation.
Import ListNotations.
Open Scope Z_scope.

Definition INT_MAX_Z : Z := 2147483647.

Fixpoint bit_count_loop_116 (fuel : nat) (n acc : Z) : Z :=
  match fuel with
  | O => acc
  | S fuel' =>
      if Z.leb n 0
      then acc
      else bit_count_loop_116 fuel' (Z.div n 2) (acc + Z.rem n 2)
  end.

Definition bit_count_116 (x : Z) : Z :=
  bit_count_loop_116 31%nat x 0.

Definition input_in_range_116 (input : list Z) : Prop :=
  forall i,
    0 <= i < Z.of_nat (length input) ->
    0 <= nth (Z.to_nat i) input 0 < INT_MAX_Z.

Definition bitcount_nondecreasing_116 (output : list Z) : Prop :=
  forall i j,
    0 <= i < j ->
    j < Z.of_nat (length output) ->
    bit_count_116 (nth (Z.to_nat i) output 0) <=
    bit_count_116 (nth (Z.to_nat j) output 0).

Definition begins_with_even_116 (output : list Z) : Prop :=
  exists h t,
    output = h :: t /\
    Z.even h = true.

Definition candidate_relation_116
  (input output : list Z) : Prop :=
  Permutation input output /\
  bitcount_nondecreasing_116 output /\
  (output = [] \/ begins_with_even_116 output).
