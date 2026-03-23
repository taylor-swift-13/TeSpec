def incr_list_spec(l, result):
    """
    Returns True if result is equal to the list obtained by incrementing 
    each element of l by 1.
    """
    expected = [x + 1 for x in l]
    return result == expected

def _impl(l: list):
    return [x + 1 for x in l]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(incr_list_spec(*input, output))

def incr_list(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
