
def precondition(args):
    l = args[0]
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(args, output):
    l = args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    return all(out_val == in_val + 1 for in_val, out_val in zip(l, output))

def _impl(l: list):
    """Return list with elements incremented by 1.
    [2, 3, 4]
    [6, 4, 6, 3, 4, 4, 10, 1, 124]"""
    return [x + 1 for x in l]

def incr_list(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
