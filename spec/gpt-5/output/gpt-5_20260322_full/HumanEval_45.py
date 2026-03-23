def triangle_area_spec(a, h, area):
    """
    Checks if the given area matches the formula for the area of a triangle:
    area = (base * height) / 2
    """
    return area == (a * h) / 2.0

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
