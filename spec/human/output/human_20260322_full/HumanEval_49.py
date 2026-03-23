def problem_49_pre(n, p):
    return n >= 0 and p > 0

def problem_49_spec(n, p, output):
    if n >= 0 and p > 0:
        return output == pow(2, n, p)
    return True

def _impl(n: int, p: int):
    res, x = 1, 2
    while n != 0:
        if n % 2 == 1:
            res = res * x % p
        x = x * x % p
        n //= 2
    return res % p

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_49_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_49_spec(*input, output))

def modp(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
