def right_angle_triangle_spec(a, b, c, res):
    expected = (a * a + b * b == c * c) or \
               (a * a + c * c == b * b) or \
               (b * b + c * c == a * a)
    return res == expected

def _impl(a, b, c):
    return a ** 2 + b ** 2 == c ** 2 or a ** 2 + c ** 2 == b ** 2 or b ** 2 + c ** 2 == a ** 2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(right_angle_triangle_spec(*input, output))

def right_angle_triangle(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
