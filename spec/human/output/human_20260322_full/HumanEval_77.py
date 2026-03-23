def problem_77_pre(a: int) -> bool:
    return True

def problem_77_spec(a: int, b: bool) -> bool:
    abs_a = abs(a)
    low = 0
    high = abs_a
    is_c = False
    while low <= high:
        mid = (low + high) // 2
        mid3 = mid * mid * mid
        if mid3 == abs_a:
            is_c = True
            break
        elif mid3 < abs_a:
            low = mid + 1
        else:
            high = mid - 1
    return b == is_c

def _impl(a):
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_77_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_77_spec(*input, output))

def iscube(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
