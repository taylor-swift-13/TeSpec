
def precondition(input):
    # input must be a tuple of two ints: (n, p) with n >= 0 and p > 0
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, p = input
    if not isinstance(n, int) or not isinstance(p, int):
        return False
    if p <= 0:
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    # output must be an int equal to (2**n) % p for given (n, p)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, p = input
    if not isinstance(n, int) or not isinstance(p, int):
        return False
    if p <= 0 or n < 0:
        return False
    if not isinstance(output, int):
        return False
    expected = pow(2, n, p)
    return output == expected

def _impl(n: int, p: int):
    """Return 2^n modulo p (be aware of numerics).
    3
    2
    1
    8
    1"""
    res, x = 1, 2
    while n != 0:
        if n % 2 == 1:
            res = res * x % p
        x = x * x % p
        n //= 2
    return res % p

def modp(n: int, p: int):
    _input = (n, p)
    assert precondition(_input)
    _output = _impl(n, p)
    assert postcondition(_input, _output)
    return _output
