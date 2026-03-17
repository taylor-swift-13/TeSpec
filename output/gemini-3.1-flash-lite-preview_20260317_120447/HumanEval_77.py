
def precondition(input):
    a = input[0]
    return isinstance(a, int)

def postcondition(input, output):
    a = input[0]
    if output:
        return round(abs(a)**(1/3))**3 == abs(a)
    else:
        return round(abs(a)**(1/3))**3 != abs(a)

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
