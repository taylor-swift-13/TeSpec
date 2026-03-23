class NumInt:
    def __init__(self, z: int):
        self.z = z

class NumOther:
    pass

def any_int_spec(x, y, z, res: bool) -> bool:
    if isinstance(x, NumInt) and isinstance(y, NumInt) and isinstance(z, NumInt):
        xi = x.z
        yi = y.z
        zi = z.z
        expected = (xi == yi + zi) or (yi == xi + zi) or (zi == yi + xi)
        return res == expected
    else:
        return res == False

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
