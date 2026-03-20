
Require Import Coq.Init.Nat.

Definition fib4_spec (n : nat) (result : nat) : Prop :=
  match n with
  | 0 => result = 0
  | 1 => result = 0
  | 2 => result = 2
  | 3 => result = 0
  | _ => exists a b c d : nat,
         a = 0 /\ b = 0 /\ c = 2 /\ d = 0 /\
         (forall i : nat, 4 <= i <= n ->
          exists a' b' c' d' : nat,
          a' = b /\ b' = c /\ c' = d /\ d' = a + b + c + d /\
          (i = n -> result = d'))
  end.
