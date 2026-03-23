def problem_35_pre(input):
    return len(input) > 0

def problem_35_spec(input, output):
    return (output in input) and all(x <= output for x in input)

def _impl(l: list):
    return max(l)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_35_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_35_spec(*input, output))

def max_element(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
