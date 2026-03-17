from typing import List

def precondition(input):
    n = input[0]
    return isinstance(n, int) and n >= 2

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) and x >= 2 for x in output):
        return False
    if output != sorted(output):
        return False
    
    product = 1
    for factor in output:
        product *= factor
        
    if product != n:
        return False
        
    for i in range(len(output)):
        for j in range(2, int(output[i]**0.5) + 1):
            if output[i] % j == 0:
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
