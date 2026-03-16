
def precondition(args):
    a = args[0]
    return isinstance(a, int)

def postcondition(args, result):
    a = args[0]
    if not isinstance(result, bool):
        return False
    if result:
        # If result is True, a must be a perfect cube
        # Find integer cube root
        root = int(round(abs(a) ** (1/3)))
        if a < 0:
            root = -root
        return root ** 3 == a
    else:
        # If result is False, a must NOT be a perfect cube
        # Check all possible integer roots
        # Bound: |root| <= ceil(|a|^(1/3)) + 1
        bound = int(abs(a) ** (1/3)) + 2
        for root in range(-bound, bound + 1):
            if root ** 3 == a:
                return False
        return True

def _impl(a):
    """Write a function that takes an integer a and returns True 
    if this ingeger is a cube of some integer number.
    Note: you may assume the input is always valid.
    Examples:
    iscube(1) ==> True
    iscube(2) ==> False
    iscube(-1) ==> True
    iscube(64) ==> True
    iscube(0) ==> True
    iscube(180) ==> False"""
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def iscube(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
