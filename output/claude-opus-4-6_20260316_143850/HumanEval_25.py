from typing import List

def precondition(input):
    n = input[0]
    return isinstance(n, int) and n >= 2

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list):
        return False
    if len(output) == 0:
        return False
    # All elements should be integers >= 2
    if not all(isinstance(f, int) and f >= 2 for f in output):
        return False
    # Product of factors should equal n
    product = 1
    for f in output:
        product *= f
    if product != n:
        return False
    # Factors should be in non-decreasing order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # Each factor should be prime
    def is_prime(x):
        if x < 2:
            return False
        if x < 4:
            return True
        if x % 2 == 0 or x % 3 == 0:
            return False
        i = 5
        while i * i <= x:
            if x % i == 0 or x % (i + 2) == 0:
                return False
            i += 6
        return True
    if not all(is_prime(f) for f in output):
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
