def sum_squares_aux(lst, idx):
    total = 0
    for x in lst:
        if idx % 3 == 0:
            total += x * x
        elif idx % 4 == 0:
            total += x * x * x
        else:
            total += x
        idx += 1
    return total

def sum_squares_spec(lst, result):
    return result == sum_squares_aux(lst, 0)

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
