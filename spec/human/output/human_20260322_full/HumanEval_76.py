def problem_76_pre(x, n):
    return True

def problem_76_spec(x, n, result):
    if x == 1:
        expected = True
    elif n == 0:
        expected = (x == 0)
    elif n == 1:
        expected = False
    elif n == -1:
        expected = (x == -1)
    else:
        expected = False
        p = 1
        while abs(p) <= abs(x):
            if p == x:
                expected = True
                break
            p *= n
            
    return result == expected

def _impl(x, n):
    if x == 1: return True
    if n == 0: return x == 0
    if n == 1: return x == 1
    if n == -1: return abs(x) == 1
    p = n
    while abs(p) <= abs(x):
        if p == x: return True
        p = p * n
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_76_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_76_spec(*input, output))

def is_simple_power(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
