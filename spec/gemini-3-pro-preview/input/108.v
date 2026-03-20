
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.
Open Scope Z_scope.

(* Helper function to obtain the decimal digits of a non-negative integer *)
Fixpoint digits_of_Z_aux (fuel : nat) (n : Z) : list Z :=
  match fuel with
  | O => []
  | S fuel' =>
      if n <? 10 then [n]
      else digits_of_Z_aux fuel' (n / 10) ++ [n mod 10]
  end.

Definition digits_of_Z (n : Z) : list Z :=
  if n =? 0 then [0]
  else digits_of_Z_aux (Z.to_nat n) n.

(* Logic to calculate the sum of signed digits as described *)
Definition signed_digits_sum (n : Z) : Z :=
  let abs_n := Z.abs n in
  let digits := digits_of_Z abs_n in
  match digits with
  | [] => 0 (* Should not be reachable for defined integers *)
  | hd :: tl =>
      let sum_rest := fold_right Z.add 0 tl in
      if n <? 0 then -hd + sum_rest else hd + sum_rest
  end.

Definition count_nums_spec (arr : list Z) (res : Z) : Prop :=
  res = Z.of_nat (length (filter (fun x => signed_digits_sum x >? 0) arr)).
