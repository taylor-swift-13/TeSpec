
def precondition(args):
    return (isinstance(args, tuple) and 
            len(args) == 2 and 
            isinstance(args[0], list) and 
            isinstance(args[1], list))

def postcondition(args, output):
    if not isinstance(output, list):
        return False
    l1, l2 = args
    try:
        expected = sorted(list(set(l1) & set(l2)))
    except TypeError:
        return False
    return output == expected

def _impl(l1: list, l2: list):
    """Return sorted unique common elements for two lists.
    [1, 5, 653]
    [2, 3]"""
    return sorted(list(set(l1).intersection(set(l2))))

def common(l1: list, l2: list):
    _input = (l1, l2)
    assert precondition(_input)
    _output = _impl(l1, l2)
    assert postcondition(_input, _output)
    return _output
