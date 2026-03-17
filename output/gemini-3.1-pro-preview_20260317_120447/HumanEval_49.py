
def precondition(inp: tuple) -> bool:
    n, p = inp
    return isinstance(n, int) and isinstance(p, int) and n >= 0 and p != 0

def postcondition(inp: tuple, out: int) -> bool:
    n, p = inp
    return out == pow(2, n, p)

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
