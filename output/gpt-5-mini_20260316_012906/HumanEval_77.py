
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    a = input[0]
    return isinstance(a, int)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    a = input[0]
    if not isinstance(output, bool):
        return False
    n = a
    # compute whether there exists integer k with k**3 == n using integer binary search
    if n >= 0:
        lo = 0
        hi = n + 1
        while lo + 1 < hi:
            mid = (lo + hi) // 2
            cube = mid * mid * mid
            if cube <= n:
                lo = mid
            else:
                hi = mid
        expected = (lo * lo * lo == n)
    else:
        m = -n
        lo = 0
        hi = m + 1
        while lo + 1 < hi:
            mid = (lo + hi) // 2
            cube = mid * mid * mid
            if cube <= m:
                lo = mid
            else:
                hi = mid
        expected = (-(lo * lo * lo) == n)
    return output == expected

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
