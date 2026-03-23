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

def count_up_to_spec(n, ans):
    """
    Checks if ans is a list of all prime numbers less than n with no duplicates.
    In Coq: Definition count_up_to_spec (n : nat) (ans : list nat) : Prop :=
            NoDup ans /\ forall p, In p ans <-> prime p /\ p < n.
    """
    # Check NoDup ans: No duplicates in the list ans
    if len(ans) != len(set(ans)):
        return False
    
    # Check forall p, In p ans -> prime p /\ p < n
    for p in ans:
        if not (prime(p) and p < n):
            return False
            
    # Check forall p, prime p /\ p < n -> In p ans
    # Since p < n and p must be a natural number, we only need to check p in range(n)
    for p in range(n):
        if prime(p):
            if p not in ans:
                return False
                
    return True
