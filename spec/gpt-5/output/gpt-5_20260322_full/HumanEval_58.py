def common_spec(l1, l2, out):
    # Check NoDup out
    if len(out) != len(set(out)):
        return False
    
    # Check Sorted Z.le out
    if out != sorted(out):
        return False
    
    # Check forall x : Z, In x out <-> (In x l1 /\ In x l2)
    if set(out) != set(l1).intersection(set(l2)):
        return False
        
    return True

def _impl(l1: list, l2: list):
    return sorted(list(set(l1).intersection(set(l2))))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(common_spec(*input, output))

def common(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
