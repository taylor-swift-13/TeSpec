
Require Import Coq.Lists.List.
Import ListNotations.
Require Import Coq.Arith.Arith.

Fixpoint derivative_spec (xs : list nat) (ds : list nat) : Prop :=
  length ds = pred (length xs) /\
  (forall i : nat, 1 <= i < length xs -> nth i ds 0 = nth i xs 0 * i).
