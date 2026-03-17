
def precondition(input_args):
    return isinstance(input_args, tuple) and len(input_args) == 1 and isinstance(input_args[0], list)

def postcondition(input_args, output):
    if not isinstance(output, list):
        return False
    l = input_args[0]
    try:
        set_l = set(l)
        set_output = set(output)
    except TypeError:
        return False
    if set_l != set_output:
        return False
    if len(output) != len(set_output):
        return False
    for i in range(len(output) - 1):
        if not (output[i] < output[i + 1]):
            return False
    return True

def _impl(l: list):
    """Return sorted unique elements in a list
    [0, 2, 3, 5, 9, 123]"""
    return sorted(set(l))

def unique(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
