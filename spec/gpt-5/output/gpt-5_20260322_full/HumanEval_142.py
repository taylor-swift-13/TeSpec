def sum_squares_aux(i, lst):
    total = 0
    for x in lst:
        if i % 3 == 0:
            term = x * x
        elif i % 4 == 0:
            term = x * x * x
        else:
            term = x
        total += term
        i += 1
    return total

def sum_squares_spec(lst, ans):
    return ans == sum_squares_aux(0, lst)

def _impl(lst):
    ans = 0
    for i, num in enumerate(lst):
        if i % 3 == 0:
            ans += num ** 2
        elif i % 4 == 0:
            ans += num ** 3
        else:
            ans += num
    return ans

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
