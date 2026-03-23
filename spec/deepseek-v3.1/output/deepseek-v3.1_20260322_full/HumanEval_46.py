def fib4_spec(n: int, result: int) -> bool:
    if n == 0:
        return result == 0
    elif n == 1:
        return result == 0
    elif n == 2:
        return result == 2
    elif n == 3:
        return result == 0
    else:
        # In the Coq specification for n >= 4, the variables a, b, c, d are 
        # existentially bound outside the forall loop and fixed to 0, 0, 2, 0.
        # Consequently, for all i in 4 <= i <= n, d' is always a + b + c + d = 2.
        # When i = n, the spec requires result = d', which means result must be 2.
        return result == 2

def _impl(n: int):
    if n == 0:
        return 0
    elif n == 1:
        return 0
    elif n == 2:
        return 2
    elif n == 3:
        return 0
    else:
        a, b, c, d = 0, 0, 2, 0
        for i in range(4, n + 1):
            a, b, c, d = b, c, d, a + b + c + d
        return d

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fib4_spec(*input, output))

def fib4(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
