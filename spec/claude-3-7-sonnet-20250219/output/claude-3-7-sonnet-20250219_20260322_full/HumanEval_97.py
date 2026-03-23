def multiply_spec(a, b, res):
    unit_digit_a = abs(a) % 10
    unit_digit_b = abs(b) % 10
    return res == unit_digit_a * unit_digit_b

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
