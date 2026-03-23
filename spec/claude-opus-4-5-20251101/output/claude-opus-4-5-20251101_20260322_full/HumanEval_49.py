def modp_spec(n: int, p: int, result: int) -> bool:
    if p <= 0:
        return False
    if n < 0:
        return result == 0
    return result == pow(2, n, p)

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
