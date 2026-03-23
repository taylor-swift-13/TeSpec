def multiply_spec(a: int, b: int, result: int) -> bool:
    return result == (abs(a) % 10) * (abs(b) % 10)

def _impl(a, b):
    return int(str(a)[-1]) * int(str(b)[-1])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(multiply_spec(*input, output))

def multiply(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
