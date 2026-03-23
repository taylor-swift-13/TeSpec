import math

def is_ceil(x, z):
    return (z - 1 < x) and (x <= z)

def problem_133_pre(lst):
    return True

def problem_133_spec(lst, s):
    expected_s = sum(math.ceil(x) ** 2 for x in lst)
    return expected_s == s

def _impl(lst):
    import math
    return sum(map(lambda x: math.ceil(x) ** 2, lst))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_133_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_133_spec(*input, output))

def sum_squares(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
