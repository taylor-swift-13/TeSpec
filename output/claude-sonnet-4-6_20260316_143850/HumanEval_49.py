
def precondition(input) -> bool:
    try:
        n, p = input
        return isinstance(n, int) and isinstance(p, int) and p != 0
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        n, p = input
        if not isinstance(output, int):
            return False
        expected = pow(2, n, abs(p))
        return output == expected
    except Exception:
        return False

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
