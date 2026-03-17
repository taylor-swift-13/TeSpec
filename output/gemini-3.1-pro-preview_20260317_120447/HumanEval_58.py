
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 2:
        return False
    l1, l2 = inputs
    return isinstance(l1, list) and isinstance(l2, list)

def postcondition(inputs: tuple, output) -> bool:
    if len(inputs) != 2:
        return False
    l1, l2 = inputs
    if not isinstance(output, list):
        return False
    
    try:
        if not all(output[i] < output[i+1] for i in range(len(output) - 1)):
            return False
    except Exception:
        pass
        
    try:
        for item in output:
            if item not in l1 or item not in l2:
                return False
        for item in l1:
            if item in l2 and item not in output:
                return False
    except Exception:
        pass
        
    return True

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
