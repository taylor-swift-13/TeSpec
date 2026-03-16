from typing import List

def precondition(input):
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
    if not precondition(input):
        return True
    n = input[0]
    if not isinstance(output, list):
        return False
    def is_prime(k):
        if k <= 1:
            return False
        if k <= 3:
            return True
        if k % 2 == 0 or k % 3 == 0:
            return False
        i = 5
        while i * i <= k:
            if k % i == 0 or k % (i + 2) == 0:
                return False
            i += 6
        return True
    # Check elements are integers > 1 and prime
    for x in output:
        if not isinstance(x, int):
            return False
        if x <= 1:
            return False
        if not is_prime(x):
            return False
    # Check non-decreasing order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # Check product equals n
    prod = 1
    for x in output:
        prod *= x
    if prod != n:
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
