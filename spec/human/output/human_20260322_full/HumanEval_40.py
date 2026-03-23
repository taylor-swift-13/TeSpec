def problem_40_pre(input):
    return True

def problem_40_spec(input, output):
    n = len(input)
    has_triple = False
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if input[i] + input[j] + input[k] == 0:
                    has_triple = True
                    break
            if has_triple:
                break
        if has_triple:
            break
    return output == has_triple

def _impl(l: list):
    for i in range(len(l)):
        for j in range(len(l)):
            for k in range(len(l)):
                if i != j and i != k and j != k and l[i] + l[j] + l[k] == 0:
                    return True
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_40_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_40_spec(*input, output))

def triples_sum_to_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
