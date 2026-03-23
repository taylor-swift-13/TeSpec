def divides(d, n):
    """
    Checks if d divides n.
    In Coq: Definition divides (d n : nat) : Prop := exists k, n = Nat.mul d k.
    """
    if d == 0:
        return n == 0
    return n % d == 0

def prime(p):
    """
    Checks if p is a prime number.
    In Coq: Definition prime (p : nat) : Prop := 2 <= p /\ forall d, 2 <= d /\ d < p -> ~ divides d p.
    """
    if p < 2:
        return False
    for d in range(2, p):
        if divides(d, p):
            return False
    return True

def _orig_count_up_to_spec(n, output):
    """
    Checks if output is a list of all prime numbers less than n with no duplicates.
    In Coq: Definition count_up_to_spec (n : nat) (output : list nat) : Prop :=
            NoDup output /\\ forall p, In p output <-> prime p /\\ p < n.
    """
    if len(output) != len(set(output)):
        return False
    for p in output:
        if not (prime(p) and p < n):
            return False
    for p in range(n):
        if prime(p):
            if p not in output:
                return False
    return True

def count_up_to_spec(n, output):
    return bool(_orig_count_up_to_spec(n, output))
