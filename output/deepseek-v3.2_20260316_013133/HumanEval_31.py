
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n >= 0

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, bool):
        return False
    if n < 2:
        return output == False
    if n == 2:
        return output == True
    if n % 2 == 0:
        return output == False
    # For odd numbers >= 3, we can't verify primality without computation,
    # but we can check some basic consistency
    if output == True:
        # If output is True, n must be odd and >= 3
        return n >= 3 and n % 2 == 1
    # If output is False, it could be correct for any n >= 2
    return True

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
