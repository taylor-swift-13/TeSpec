from typing import List

def is_prime(p):
    if p <= 1:
        return False
    for d in range(2, int(p**0.5) + 1):
        if p % d == 0:
            return False
    return True

def factorize_spec(n, factors):
    prod = 1
    for f in factors:
        prod *= f
    
    if prod != n:
        return False
        
    for f in factors:
        if not is_prime(f):
            return False
            
    for i in range(len(factors) - 1):
        if factors[i] > factors[i+1]:
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
