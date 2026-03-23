def get_positive_spec(l, result):
    return result == [x for x in l if x > 0]

def _impl(l: list):
    return list(filter(lambda x: x > 0, l))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_positive_spec(*input, output))

def get_positive(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
