def problem_57_pre(l):
    return True

def problem_57_spec(l, b):
    is_inc = all(l[i] <= l[i+1] for i in range(len(l)-1))
    is_dec = all(l[i] >= l[i+1] for i in range(len(l)-1))
    return b == (is_inc or is_dec)

def _impl(l: list):
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_57_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_57_spec(*input, output))

def monotonic(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
