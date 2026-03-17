
def precondition(input):
    if len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    a = input[0]
    # Check if output correctly identifies whether a is a perfect cube
    # A number is a perfect cube if there exists an integer n such that n^3 == a
    if a >= 0:
        cube_root = round(a ** (1/3))
    else:
        cube_root = -round(abs(a) ** (1/3))
    # Check nearby integers due to floating point precision issues
    for candidate in [cube_root - 1, cube_root, cube_root + 1]:
        if candidate ** 3 == a:
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
