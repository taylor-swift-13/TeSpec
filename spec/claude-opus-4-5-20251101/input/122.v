
Require Import ZArith.
Require Import List.
Require Import Lia.
Import ListNotations.

Open Scope Z_scope.

Definition digits (x : Z) : Z :=
  let abs_x := Z.abs x in
  if abs_x <? 10 then 1
  else if abs_x <? 100 then 2
  else if abs_x <? 1000 then 3
  else if abs_x <? 10000 then 4
  else 5.

Definition has_at_most_two_digits (x : Z) : bool :=
  (digits x <=? 2).

Fixpoint firstn_Z (n : nat) (l : list Z) : list Z :=
  match n with
  | O => []
  | S n' => match l with
            | [] => []
            | x :: xs => x :: firstn_Z n' xs
            end
  end.

Fixpoint filter_sum (f : Z -> bool) (l : list Z) : Z :=
  match l with
  | [] => 0
  | x :: xs => if f x then x + filter_sum f xs else filter_sum f xs
  end.

Definition add_elements_spec (arr : list Z) (k : nat) (result : Z) : Prop :=
  result = filter_sum has_at_most_two_digits (firstn_Z k arr).
