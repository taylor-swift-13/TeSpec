def problem_43_pre(input):
    return True

def problem_43_spec(input, output):
    has_pair = False
    n = len(input)
    for i in range(n):
        for j in range(i + 1, n):
            if input[i] + input[j] == 0:
                has_pair = True
                break
        if has_pair:
            break
    return output == has_pair

def _impl(l):
    for i in range(len(l)):
        for j in range(len(l)):
            if i != j and l[i] + l[j] == 0:
                return True
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_43_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_43_spec(*input, output))

def pairs_sum_to_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
