
Require Import Coq.Arith.Arith.

Definition fib_spec (n : nat) (fib_n : nat) : Prop :=
  (n = 0 -> fib_n = 0) /\
  (n = 1 \/ n = 2 -> fib_n = 1) /\
  (n >= 3 -> exists a b, 
    a = 1 /\ b = 1 /\ 
    (forall i, 3 <= i <= n -> exists a_i b_i, 
      a_i = b /\ b_i = a + b /\ a = a_i /\ b = b_i) /\ 
    fib_n = b).
