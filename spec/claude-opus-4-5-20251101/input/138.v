
Require Import ZArith.
Require Import Bool.

Open Scope Z_scope.

Definition is_equal_to_sum_even_spec (n : Z) (result : bool) : Prop :=
  result = true <-> (n >= 8 /\ Z.even n = true /\ 
    exists a b c d : Z, a > 0 /\ b > 0 /\ c > 0 /\ d > 0 /\
                        Z.even a = true /\ Z.even b = true /\ 
                        Z.even c = true /\ Z.even d = true /\
                        n = a + b + c + d).
