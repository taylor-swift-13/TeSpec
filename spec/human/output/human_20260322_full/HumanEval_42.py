def problem_42_pre(input):
    return True

def problem_42_spec(input, output):
    if len(input) != len(output):
        return False
    for i in range(len(output)):
        if output[i] != input[i] + 1:
            return False
    return True

def _impl(l: list):
    return [x + 1 for x in l]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_42_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_42_spec(*input, output))

def incr_list(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
