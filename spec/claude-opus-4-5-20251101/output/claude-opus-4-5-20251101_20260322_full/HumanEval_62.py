def derivative_spec(xs, result):
    expected_len = max(0, len(xs) - 1)
    if len(result) != expected_len:
        return False
    for i in range(len(result)):
        if result[i] != xs[i + 1] * (i + 1):
            return False
    return True

def _impl(xs: list):
    return [xs[i] * i for i in range(1, len(xs))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(derivative_spec(*input, output))

def derivative(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
