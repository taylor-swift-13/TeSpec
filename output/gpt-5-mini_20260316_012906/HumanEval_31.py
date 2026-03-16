
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # require an integer (exclude booleans)
    return type(n) is int

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    # output must be a boolean
    if type(output) is not bool:
        return False
    # define primality according to standard definition: integers > 1 with no divisors other than 1 and itself
    if n <= 1:
        return output is False
    if n <= 3:
        return output is True
    if n % 2 == 0:
        return output is False
    # check odd divisors up to sqrt(n)
    r = int(n**0.5)
    i = 3
    while i <= r:
        if n % i == 0:
            return output is False
        i += 2
    return output is True

def _impl(n):
    """Return true if a given number is prime, and false otherwise.
    False
    True
    True
    True
    True
    False
    False"""
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True

def is_prime(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
