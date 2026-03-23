def triangle_area_spec(a, h, res):
    return res == a * h / 2

def _impl(a, h):
    return a * h / 2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(triangle_area_spec(*input, output))

def triangle_area(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
