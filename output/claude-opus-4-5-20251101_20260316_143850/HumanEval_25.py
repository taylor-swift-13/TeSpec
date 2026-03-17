from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 2:
        return False
    return True


def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list):
        return False
    if len(output) == 0:
        return False
    for factor in output:
        if not isinstance(factor, int):
            return False
        if factor < 2:
            return False
    # Check factors are sorted from smallest to largest
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # Check product equals input
    product = 1
    for factor in output:
        product *= factor
    if product != n:
        return False
    # Check each factor is prime
    def is_prime(x):
        if x < 2:
            return False
        if x == 2:
            return True
        if x % 2 == 0:
            return False
        for i in range(3, int(x ** 0.5) + 1, 2):
            if x % i == 0:
                return False
        return True
    for factor in output:
        if not is_prime(factor):
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
