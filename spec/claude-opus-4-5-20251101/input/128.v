
Require Import ZArith.
Require Import List.
Require Import Coq.Bool.Bool.

Open Scope Z_scope.

Definition sign (x : Z) : Z :=
  if x <? 0 then -1
  else if x >? 0 then 1
  else 0.

Definition abs (x : Z) : Z :=
  if x <? 0 then -x else x.

Fixpoint sum_magnitudes (arr : list Z) : Z :=
  match arr with
  | nil => 0
  | x :: xs => abs x + sum_magnitudes xs
  end.

Fixpoint product_signs (arr : list Z) : Z :=
  match arr with
  | nil => 1
  | x :: xs => sign x * product_signs xs
  end.

Fixpoint contains_zero (arr : list Z) : bool :=
  match arr with
  | nil => false
  | x :: xs => if x =? 0 then true else contains_zero xs
  end.

Definition prod_signs_spec (arr : list Z) (result : option Z) : Prop :=
  match arr with
  | nil => result = None
  | _ => 
    if contains_zero arr then result = Some 0
    else result = Some (sum_magnitudes arr * product_signs arr)
  end.
