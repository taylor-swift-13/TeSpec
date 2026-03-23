def is_increasing(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def is_decreasing(l):
    for i in range(len(l) - 1):
        if l[i] < l[i + 1]:
            return False
    return True

def monotonic_spec(l, result):
    return bool(result) == (is_increasing(l) or is_decreasing(l))

def _impl(l: list):
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(monotonic_spec(*input, output))

def monotonic(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
