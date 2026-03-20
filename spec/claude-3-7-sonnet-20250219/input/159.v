
Require Import Coq.Lists.List.
Import ListNotations.

Definition eat_spec (number need remaining : nat) (result : list nat) : Prop :=
  0 <= number <= 1000 /\
  0 <= need <= 1000 /\
  0 <= remaining <= 1000 /\
  (if Nat.leb need remaining
   then result = [(number + need)%nat; (remaining - need)%nat]
   else result = [(number + remaining)%nat; 0]).
