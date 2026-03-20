
Require Import Coq.Lists.List.
Require Import Coq.Arith.Arith.
Import ListNotations.

Fixpoint tri_elem (n : nat) : nat :=
  match n with
  | 0 => 1
  | 1 => 3
  | S p =>
      match p with
      | 0 => 3
      | S q =>
          if Nat.even n then
            1 + Nat.div2 n
          else
            tri_elem p + tri_elem q + (1 + Nat.div2 (n + 1))
      end
  end.

Definition tri_spec (n : nat) (l : list nat) : Prop :=
  l = map tri_elem (seq 0 (n + 1)).
