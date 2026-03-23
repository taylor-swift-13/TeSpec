def problem_72_pre(q, w):
    return True

def problem_72_spec(q, w, output):
    is_palindrome = (q == q[::-1])
    is_light = (sum(q) <= w)
    expected = is_palindrome and is_light
    return output == expected

def _impl(q, w):
    return q == q[::-1] and sum(q) <= w

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_72_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_72_spec(*input, output))

def will_it_fly(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
