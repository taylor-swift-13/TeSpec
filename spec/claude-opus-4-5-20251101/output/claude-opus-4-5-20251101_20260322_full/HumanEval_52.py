def below_threshold_spec(l, t, result):
    return result == all(x < t for x in l)

def _impl(l: list, t: int):
    return all(x < t for x in l)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(below_threshold_spec(*input, output))

def below_threshold(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
