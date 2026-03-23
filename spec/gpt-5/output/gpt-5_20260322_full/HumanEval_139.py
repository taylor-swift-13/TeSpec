def fact(n):
    res = 1
    for i in range(1, n + 1):
        res *= i
    return res

def brazilian_factorial(n):
    res = 1
    for i in range(1, n + 1):
        res *= fact(i)
    return res

def special_factorial_spec(n, ans):
    return ans == brazilian_factorial(n)

def _impl(n):
    fac, ans = 1, 1
    for i in range(2, n + 1):
        fac *= i
        ans *= fac
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(special_factorial_spec(*input, output))

def special_factorial(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
