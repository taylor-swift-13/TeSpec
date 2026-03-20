
Require Import Coq.ZArith.ZArith.
Require Import Coq.Lists.List.
Import ListNotations.

Open Scope Z_scope.

Fixpoint factorial (n : nat) : Z :=
  match n with
  | O => 1
  | S n' => Z.of_nat n * factorial n'
  end.

Fixpoint brazilian_factorial (n : nat) : Z :=
  match n with
  | O => 1
  | S n' => factorial n * brazilian_factorial n'
  end.

Definition special_factorial_spec (n : Z) (result : Z) : Prop :=
  n > 0 /\ result = brazilian_factorial (Z.to_nat n).
