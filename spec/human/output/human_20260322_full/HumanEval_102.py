def problem_102_pre(x: int, y: int) -> bool:
    return x > 0 and y > 0

def problem_102_spec(x: int, y: int, res: int) -> bool:
    if x > y:
        expected = -1
    else:
        largest_even = y if y % 2 == 0 else y - 1
        if largest_even >= x:
            expected = largest_even
        else:
            expected = -1
    return res == expected

def _impl(x, y):
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_102_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_102_spec(*input, output))

def choose_num(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
