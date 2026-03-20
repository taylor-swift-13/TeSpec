
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Require Import Coq.Sorting.Permutation.
Require Import Coq.Sorting.Sorted.
Import ListNotations.
Open Scope Z_scope.

(* Helper function to extract digits from a natural number. 
   Uses fuel to ensure structural termination. *)
Fixpoint nat_to_digits_rev (n : nat) (fuel : nat) : list Z :=
  match fuel with
  | 0%nat => []
  | S f =>
    match n with
    | 0%nat => []
    | _ => Z.of_nat (n mod 10) :: nat_to_digits_rev (n / 10) f
    end
  end.

(* Helper to get the list of digits of a Z in most-significant-first order. *)
Definition get_digits (z : Z) : list Z :=
  match z with
  | 0 => [0]
  | _ => 
    let n := Z.to_nat (Z.abs z) in
    rev (nat_to_digits_rev n (S n))
  end.

(* Computes the sum of a list of integers. *)
Fixpoint sum_list (l : list Z) : Z :=
  match l with
  | [] => 0
  | h :: t => h + sum_list t
  end.

(* The weighting function defined in the Python code.
   If x >= 0, sum of digits.
   If x < 0, negate the first digit (which represents the negative sign interaction) and sum the rest. *)
Definition weight (x : Z) : Z :=
  let ds := get_digits x in
  if x <? 0 then
    match ds with
    | [] => 0 (* Unreachable for non-zero inputs *)
    | h :: t => (-h) + sum_list t
    end
  else
    sum_list ds.

(* Order relation for the stable sort.
   Compares by weight first, then by original index to ensure stability. *)
Definition weight_index_le (p1 p2 : Z * nat) : Prop :=
  let (v1, i1) := p1 in
  let (v2, i2) := p2 in
  weight v1 < weight v2 \/ (weight v1 = weight v2 /\ (i1 <= i2)%nat).

(* The main specification.
   Asserts that the result is a permutation of the input,
   sorted according to the weight and the original index (stable sort). *)
Definition order_by_points_spec (nums : list Z) (res : list Z) : Prop :=
  let indexed_nums := combine nums (seq 0 (length nums)) in
  exists indexed_res,
    Permutation indexed_nums indexed_res /\
    Sorted weight_index_le indexed_res /\
    res = map fst indexed_res.
