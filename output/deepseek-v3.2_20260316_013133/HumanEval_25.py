from typing import List

def precondition(args):
    n = args[0]
    return isinstance(n, int) and n > 1

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, list):
        return False
    if not all(isinstance(x, int) and x > 1 for x in result):
        return False
    if len(result) == 0:
        return False
    product = 1
    for factor in result:
        product *= factor
    if product != n:
        return False
    for i in range(len(result) - 1):
        if result[i] > result[i + 1]:
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
