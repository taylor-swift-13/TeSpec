 
Require Import Coq.Lists.List.
Require Import Coq.ZArith.ZArith.
Import ListNotations.

Open Scope Z_scope.

Fixpoint make_a_pile_aux (n : Z) (current : Z) (fuel : nat) : list Z :=
  match fuel with
  | O => []
  | S fuel' => current :: make_a_pile_aux n (current + 2) fuel'
  end.

Definition make_a_pile_spec (n : Z) (result : list Z) : Prop :=
  n > 0 ->
  Z.of_nat (length result) = n /\
  (forall i, (0 <= i < n)%Z ->
    nth (Z.to_nat i) result 0 = n + 2 * i).
