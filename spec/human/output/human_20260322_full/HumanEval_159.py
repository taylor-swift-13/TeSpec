def problem_159_pre(number, need, remaining):
    return (0 <= number <= 1000) and (0 <= need <= 1000) and (0 <= remaining <= 1000)

def problem_159_spec(number, need, remaining, result):
    if remaining >= need:
        return result == [number + need, remaining - need]
    else:
        return result == [number + remaining, 0]

def _impl(number, need, remaining):
    if need <= remaining:
        return [number + need, remaining - need]
    else:
        return [number + remaining, 0]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_159_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_159_spec(*input, output))

def eat(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
