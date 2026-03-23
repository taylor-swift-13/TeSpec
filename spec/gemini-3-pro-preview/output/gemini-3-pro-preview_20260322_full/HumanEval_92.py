def any_int_spec(x, y, z, res):
    return res == ((x == y + z) or (y == x + z) or (z == x + y))

def _impl(x, y, z):
    if type(x) != int or type(y) != int or type(z) != int: return False
    return x == y + z or y == x + z or z == y + x

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(any_int_spec(*input, output))

def any_int(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
