def problem_151_pre(l):
    return True

def problem_151_spec(l, res):
    acc = 0
    for h in l:
        if h >= 0 and h % 2 != 0:
            acc += h * h
    return res == acc

def _impl(lst):
    ans = 0
    for num in lst:
        if num % 2 == 1 and num > 0 and "." not in str(num):
            ans += num ** 2
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_151_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_151_spec(*input, output))

def double_the_difference(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
