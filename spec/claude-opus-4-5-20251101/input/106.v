
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.

Open Scope Z_scope.

Fixpoint factorial (n : nat) : Z :=
  match n with
  | O => 1
  | S n' => Z.of_nat n * factorial n'
  end.

Fixpoint sum_1_to_n (n : nat) : Z :=
  match n with
  | O => 0
  | S n' => Z.of_nat n + sum_1_to_n n'
  end.

Definition f_element (i : nat) : Z :=
  if Nat.even i then factorial i
  else sum_1_to_n i.

Fixpoint f_list (n : nat) : list Z :=
  match n with
  | O => []
  | S n' => f_list n' ++ [f_element n]
  end.

Definition f_spec (n : nat) (result : list Z) : Prop :=
  result = f_list n /\
  length result = n /\
  forall i : nat, (1 <= i <= n)%nat ->
    nth (i - 1) result 0 = f_element i.
