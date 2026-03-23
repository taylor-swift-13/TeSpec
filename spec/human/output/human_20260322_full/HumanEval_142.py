def sum_transformed(l, n):
    total = 0
    for h in l:
        if n % 3 == 0:
            transformed = h * h
        elif n % 4 == 0 and n % 3 != 0:
            transformed = h * h * h
        else:
            transformed = h
        total += transformed
        n += 1
    return total

def sum_squares_impl(lst):
    return sum_transformed(lst, 0)

def problem_142_pre(lst):
    return True

def problem_142_spec(lst, output):
    return output == sum_squares_impl(lst)

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_142_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_142_spec(*input, output))

def sum_squares(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
