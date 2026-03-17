
def precondition(input_args):
    return len(input_args) == 1 and isinstance(input_args[0], int)

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    a = input_args[0]
    # A number a is a cube if there exists an integer n such that n^3 = a.
    # This is equivalent to |n|^3 = |a|.
    root = round(abs(a)**(1/3))
    is_perfect_cube = (root**3 == abs(a))
    return output == is_perfect_cube

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
