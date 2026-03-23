def problem_163_pre(a, b):
    return a > 0 and b > 0

def problem_163_spec(a, b, l):
    lower = min(a, b)
    upper = max(a, b)
    
    expected = []
    for d in range(lower, upper + 1):
        if d < 10 and d % 2 == 0:
            expected.append(d)
            
    return l == expected

def _impl(a, b):
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_163_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_163_spec(*input, output))

def generate_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
