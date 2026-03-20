
Require Import Nat.

Definition is_prime_spec (n : nat) (result : bool) : Prop :=
  (n <= 1 -> result = false) /\
  (n > 1 ->
   (exists i, 2 <= i < n /\ n mod i = 0 -> result = false) /\
   (forall i, 2 <= i < n -> n mod i <> 0 -> result = true)).
