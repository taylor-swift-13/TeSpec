from typing import List

def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 1

def postcondition(args, output):
    n = args[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    if output != sorted(output):
        return False
    
    product = 1
    for x in output:
        product *= x
    if product != n:
        return False
        
    for x in output:
        if x < 2:
            return False
        for i in range(2, int(x**0.5) + 1):
            if x % i == 0:
                return False
    return True

def _impl(n: int) -> List[int]:
    """Return list of prime factors of given integer in the order from smallest to largest.
    Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
    Input number should be equal to the product of all factors
    [2, 2, 2]
    [5, 5]
    [2, 5, 7]"""
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

def factorize(n: int) -> List[int]:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
