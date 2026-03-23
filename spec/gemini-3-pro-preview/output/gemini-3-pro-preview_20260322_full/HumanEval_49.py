def modp_spec(n: int, p: int, result: int) -> bool:
    if n < 0:
        ans = 0
    elif p == 0:
        ans = 2 ** n
    elif p > 0:
        ans = pow(2, n, p)
    else:
        # For p < 0, Coq's Z.modulo returns a non-positive remainder.
        # We compute (2^n) mod |p| first, which is in [0, |p|-1].
        r = pow(2, n, abs(p))
        if r == 0:
            ans = 0
        else:
            # Adjust to the range (p, 0]
            ans = r + p
    return result == ans

def _impl(n: int, p: int):
    res, x = 1, 2
    while n != 0:
        if n % 2 == 1:
            res = res * x % p
        x = x * x % p
        n //= 2
    return res % p

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(modp_spec(*input, output))

def modp(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
