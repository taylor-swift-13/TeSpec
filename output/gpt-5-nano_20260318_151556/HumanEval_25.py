from typing import List

def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    def is_prime(x):
        if x < 2:
            return False
        if x % 2 == 0:
            return x == 2
        i = 3
        while i * i <= x:
            if x % i == 0:
                return False
            i += 2
        return True

    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    if not isinstance(output, list):
        return False

    if n == 1:
        return output == []

    # For n > 1, there should be a non-empty list of prime factors
    if len(output) == 0:
        return False

    # Check format: sorted nondecreasing, all primes
    for idx, f in enumerate(output):
        if not isinstance(f, int):
            return False
        if f < 2:
            return False
        if not is_prime(f):
            return False
        if idx > 0 and output[idx - 1] > f:
            return False

    # Check product equals n
    prod = 1
    for f in output:
        prod *= f
    if prod != n:
        return False

    return True

def _impl(n: int) -> List[int]:
    """
    Return list of prime factors of given integer in the order from smallest to largest.
    Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
    Input number should be equal to the product of all factors
    [2, 2, 2]
    [5, 5]
    [2, 5, 7]
    """
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
