def problem_92_pre(x, y, z):
    return True

def problem_92_spec(x, y, z, b):
    try:
        if x != int(x) or y != int(y) or z != int(z):
            cond = False
        else:
            cond = (x == y + z) or (y == x + z) or (z == x + y)
    except Exception:
        cond = False
        
    return b == cond

def _impl(x, y, z):
    if type(x) != int or type(y) != int or type(z) != int: return False
    return x == y + z or y == x + z or z == y + x

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_92_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_92_spec(*input, output))

def any_int(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
