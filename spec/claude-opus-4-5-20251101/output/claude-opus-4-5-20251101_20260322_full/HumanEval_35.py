def max_element_spec(l, result):
    if not l:
        return False
    if result not in l:
        return False
    return all(x <= result for x in l)

def _impl(l: list):
    return max(l)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(max_element_spec(*input, output))

def max_element(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
