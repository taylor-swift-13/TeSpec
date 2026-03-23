import math

def up(x):
    return math.floor(x) + 1

def sum_squares_spec(lst, result):
    expected_sum = sum(up(x) * up(x) for x in lst)
    return result == expected_sum

def _impl(lst):
    import math
    return sum(map(lambda x: math.ceil(x) ** 2, lst))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sum_squares_spec(*input, output))

def sum_squares(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
