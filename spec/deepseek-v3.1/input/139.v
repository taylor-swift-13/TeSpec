
Definition special_factorial_spec (n : nat) (result : nat) : Prop :=
  match n with
  | O => result = 1
  | S _ => exists (fac ans : nat),
             fac = 1 /\
             ans = 1 /\
             (forall i : nat, 2 <= i <= n ->
               exists (fac' ans' : nat),
                 fac' = fac * i /\
                 ans' = ans * fac' /\
                 fac = fac' /\
                 ans = ans') /\
             result = ans
  end.
