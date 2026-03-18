
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    # If precondition doesn't hold, don't over-restrict
    if not precondition(input):
        return True
    n = input[0]
    def is_prime(x):
        if x <= 1:
            return False
        if x <= 3:
            return True
        if x % 2 == 0 or x % 3 == 0:
            return False
        i = 5
        w = 2
        while i * i <= x:
            if x % i == 0:
                return False
            i += w
            w = 6 - w
        return True
    expected = is_prime(n)
    return isinstance(output, bool) and output == expected

def _impl(n):
    """
    Return true if a given number is prime, and false otherwise.
    False
    True
    True
    True
    True
    False
    False
    """
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
