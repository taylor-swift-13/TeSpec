def problem_58_pre(l1, l2):
    return True

def problem_58_spec(l1, l2, l_out):
    expected = sorted(list(set(l1).intersection(set(l2))))
    return l_out == expected

def _impl(l1: list, l2: list):
    return sorted(list(set(l1).intersection(set(l2))))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_58_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_58_spec(*input, output))

def common(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
