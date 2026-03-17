
def precondition(input):
    (a,) = input
    return isinstance(a, int)


def postcondition(input, output):
    (a,) = input
    if not isinstance(output, bool):
        return False
    # Check correctness: a is a perfect cube iff round(|a|^(1/3))^3 == a
    # We search for an integer n such that n^3 == a
    if a >= 0:
        n = round(a ** (1.0 / 3.0))
    else:
        n = -round((-a) ** (1.0 / 3.0))
    # Check nearby values to handle floating point issues
    is_cube = False
    for candidate in [n - 1, n, n + 1]:
        if candidate ** 3 == a:
            is_cube = True
            break
    return output == is_cube

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
