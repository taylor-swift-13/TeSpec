import math

def sum_list(l):
    return sum(l)

def divceil(n, c):
    if c == 0:
        return 0
    return (n + c - 1) // c

def max_fill_spec(grid, capacity, ans):
    expected = sum(divceil(sum_list(l), capacity) for l in grid)
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
