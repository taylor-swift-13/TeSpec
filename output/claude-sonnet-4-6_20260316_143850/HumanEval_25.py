from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
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
    # Each factor must be an integer >= 2
    for f in output:
        if not isinstance(f, int):
            return False
        if f < 2:
            return False
    # Each factor must be prime
    for f in output:
        if f < 2:
            return False
        for d in range(2, int(f**0.5) + 1):
            if f % d == 0:
                return False
    # Product of factors must equal n
    product = 1
    for f in output:
        product *= f
    if product != n:
        return False
    # Factors must be in non-decreasing order
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
