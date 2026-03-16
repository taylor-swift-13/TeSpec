from typing import List

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int) or n < 1:
        return False
    if not isinstance(output, list):
        return False

    prod = 1
    for x in output:
        if not isinstance(x, int) or x < 2:
            return False
        prod *= x
    if prod != n:
        return False

    for i in range(1, len(output)):
        if output[i] < output[i - 1]:
            return False

    def is_prime(k: int) -> bool:
        if k < 2:
            return False
        if k % 2 == 0:
            return k == 2
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True

    for x in output:
        if not is_prime(x):
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
