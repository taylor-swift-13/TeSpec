from typing import List

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

def factorize_spec(n, fact):
    """
    Definition factorize_spec (n : Z) (fact : list Z) : Prop :=
      1 <= n /\ Sorted Z.le fact /\ Forall is_prime fact /\ list_prod fact = n.
    """
    # 1 <= n
    if not (1 <= n):
        return False
    
    # Sorted Z.le fact
    # Z.le is <=. The list must be sorted in non-decreasing order.
    for i in range(len(fact) - 1):
        if not (fact[i] <= fact[i+1]):
            return False
            
    # Forall is_prime fact
    for x in fact:
        if not is_prime(x):
            return False
            
    # list_prod fact = n
    if list_prod(fact) != n:
        return False
        
    return True

def _impl(n: int) -> List[int]:
    import math
    fact = []
    i = 2
    while i <= int(math.sqrt(n) + 1):
        if n % i == 0:
            fact.append(i)
            n //= i
        else:
            i += 1
    if n > 1:
        fact.append(n)
    return fact

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(factorize_spec(*input, output))

def factorize(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
