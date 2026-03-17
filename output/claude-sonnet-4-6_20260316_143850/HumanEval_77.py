
def precondition(args):
    a = args[0]
    return isinstance(a, int)

def postcondition(args, output):
    a = args[0]
    if not isinstance(output, bool):
        return False
    cbrt = round(abs(a) ** (1/3))
    for candidate in [cbrt - 1, cbrt, cbrt + 1]:
        if candidate ** 3 == abs(a):
            return output == True
    return output == False

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
