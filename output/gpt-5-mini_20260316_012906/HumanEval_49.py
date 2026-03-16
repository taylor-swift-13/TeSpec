
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    n, p = input
    if not isinstance(n, int) or not isinstance(p, int):
        return False
    if n < 0:
        return False
    if p <= 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n, p = input
    if not isinstance(output, int):
        return False
    try:
        expected = pow(2, n, p)
    except Exception:
        return False
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
