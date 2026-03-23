def _orig_is_prime_spec(n, output):
    """
    Executable Python implementation of the Coq is_prime_spec.
    
    The Coq spec is defined as:
    Definition is_prime_spec (n : nat) (output : bool) : Prop :=
      (n <= 1 -> output = false) /      (n > 1 ->
       (exists i, 2 <= i < n /\\ n mod i = 0 -> output = false) /       (forall i, 2 <= i < n -> n mod i <> 0 -> output = true)).
    """
    if n <= 1:
        if output != False:
            return False
    if n > 1:
        exists_cond = True
        forall_cond = True
        for i in range(2, n):
            if n % i != 0:
                if output != True:
                    forall_cond = False
                    break
        if not (exists_cond and forall_cond):
            return False
    return True

def is_prime_spec(n, output):
    return bool(_orig_is_prime_spec(n, output))
