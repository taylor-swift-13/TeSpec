def is_prime(p):
    """
    Definition is_prime (p : Z) : Prop :=
      2 <= p /\ forall d, 2 <= d < p -> ~ Z.divide d p.
    """
    if p < 2:
        return False
    if p == 2:
        return True
    if p % 2 == 0:
        return False
    
    # Check for divisors up to sqrt(p)
    d = 3
    while d * d <= p:
        if p % d == 0:
            return False
        d += 2
    return True

def list_prod(l):
    """
    Fixpoint list_prod (l : list Z) : Z :=
      match l with
      | nil => 1
      | x :: xs => x * list_prod xs
      end.
    """
    res = 1
    for x in l:
        res *= x
    return res

def _orig_factorize_spec(n, fact):
    """
    Definition factorize_spec (n : Z) (fact : list Z) : Prop :=
      1 <= n /\\ Sorted Z.le fact /\\ Forall is_prime fact /\\ list_prod fact = n.
    """
    if not 1 <= n:
        return False
    for i in range(len(fact) - 1):
        if not fact[i] <= fact[i + 1]:
            return False
    for x in fact:
        if not is_prime(x):
            return False
    if list_prod(fact) != n:
        return False
    return True

def factorize_spec(n, output):
    return bool(_orig_factorize_spec(n, output))
