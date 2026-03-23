import math

def sum_list(l):
    return sum(l)

def z_div(a, b):
    if b == 0:
        return 0
    if b > 0:
        return a // b
    return (-a - b - 1) // (-b)

def max_fill_spec(grid, capacity, ans):
    expected = 0
    for row in grid:
        val = z_div(sum_list(row) + capacity - 1, capacity)
        expected += val
    return ans == expected

def _impl(grid, capacity):
    ans = 0
    for l in grid:
        ans += math.ceil(sum(l) / capacity)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(max_fill_spec(*input, output))

def max_fill(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
