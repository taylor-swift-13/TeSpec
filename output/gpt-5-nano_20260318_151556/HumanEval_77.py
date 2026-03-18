
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    a = input[0]
    return isinstance(a, int)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int):
        return False

    def is_perfect_cube(n):
        m = abs(n)
        left, right = 0, m
        while left <= right:
            mid = (left + right) // 2
            cube = mid * mid * mid
            if cube == m:
                return True
            if cube < m:
                left = mid + 1
            else:
                right = mid - 1
        return False

    expected = is_perfect_cube(a)
    return isinstance(output, bool) and output == expected

def _impl(a):
    """
    Write a function that takes an integer a and returns True 
    if this ingeger is a cube of some integer number.
    Note: you may assume the input is always valid.
    Examples:
    iscube(1) ==> True
    iscube(2) ==> False
    iscube(-1) ==> True
    iscube(64) ==> True
    iscube(0) ==> True
    iscube(180) ==> False
    """
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def iscube(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
