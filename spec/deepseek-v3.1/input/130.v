
Require Import List ZArith.
Import ListNotations.

Definition tri_spec (n : nat) (result : list nat) : Prop :=
  match n with
  | 0 => result = [1]
  | 1 => result = [1; 3]
  | _ => 
      exists (ans : list nat),
      ans = [1; 3] /\
      (forall i : nat, 2 <= i <= n ->
        (Nat.even i = true -> nth (i-2) ans 0 + 1 + i / 2 = nth (i-1) ans 0) /\
        (Nat.even i = false -> 
          nth (i-2) ans 0 + nth (i-3) ans 0 + 1 + (i+1)/2 = nth (i-1) ans 0)) /\
      result = ans
  end.
