
def precondition(input):
    (n,) = input
    return isinstance(n, int)

def postcondition(input, output):
    (n,) = input
    if not isinstance(output, bool):
        return False
    if n < 2:
        if output != False:
            return False
    elif n == 2:
        if output != True:
            return False
    elif n % 2 == 0:
        if output != False:
            return False
    else:
        is_prime = True
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                is_prime = False
                break
        if output != is_prime:
            return False
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
