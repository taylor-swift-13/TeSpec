
def precondition(input):
    # input should be a tuple of (n, p) with n >= 0 and p > 0
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
    # output should be 2^n mod p for given input (n, p)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    n, p = input
    if not isinstance(n, int) or not isinstance(p, int):
        return False
    if p <= 0:
        return False
    if not isinstance(output, int):
        return False
    if n < 0:
        return False
    try:
        expected = pow(2, n, p)
    except Exception:
        return False
    return output == expected

def _impl(n: int, p: int):
    """
    Return 2^n modulo p (be aware of numerics).
    3
    2
    1
    8
    1
    """
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
