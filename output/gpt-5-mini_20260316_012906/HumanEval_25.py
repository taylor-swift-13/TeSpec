from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    n = input[0]
    # accept positive integers (1 allowed); exclude 0 and negatives
    return isinstance(n, int) and n >= 1

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    # output must be a list
    if not isinstance(output, list):
        return False
    # for n == 1, the prime factor list should be empty
    if n == 1:
        return output == []
    # for n > 1, output must be non-empty
    if len(output) == 0:
        return False
    # helper primality check
    def is_prime(p):
        if not isinstance(p, int) or p < 2:
            return False
        if p % 2 == 0:
            return p == 2
        i = 3
        while i * i <= p:
            if p % i == 0:
                return False
            i += 2
        return True
    prod = 1
    for x in output:
        if not isinstance(x, int):
            return False
        if x < 2:
            return False
        if not is_prime(x):
            return False
        prod *= x
    # product of factors must equal the input number
    if prod != n:
        return False
    # factors must be sorted from smallest to largest (non-decreasing)
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
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
