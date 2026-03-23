import math

def sum_squares_spec(lst, res):
    # In Coq, `up x` is defined such that `up x - 1 <= x < up x`.
    # This means `up x` is the smallest integer strictly greater than `x`,
    # which is equivalent to `math.floor(x) + 1`.
    expected = sum((math.floor(x) + 1) ** 2 for x in lst)
    return res == expected

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
