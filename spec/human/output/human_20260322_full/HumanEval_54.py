def problem_54_pre(s0: str, s1: str) -> bool:
    return True

def problem_54_spec(s0: str, s1: str, b: bool) -> bool:
    return b == (set(s0) == set(s1))

def _impl(s0: str, s1: str):
    return set(s0) == set(s1)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_54_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_54_spec(*input, output))

def same_chars(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
