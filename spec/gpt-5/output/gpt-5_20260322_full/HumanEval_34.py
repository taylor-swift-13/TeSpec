def unique_spec(l, res):
    # Check if res is sorted in ascending order
    if res != sorted(res):
        return False
    
    # Check if res has no duplicates
    if len(res) != len(set(res)):
        return False
    
    # Check if the elements in res are exactly the elements in l
    if set(res) != set(l):
        return False
    
    return True

def _impl(l: list):
    return sorted(set(l))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(unique_spec(*input, output))

def unique(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
