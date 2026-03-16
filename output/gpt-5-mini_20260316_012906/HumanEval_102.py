
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    x, y = input
    for v in (x, y):
        if isinstance(v, bool):
            return False
        if not isinstance(v, (int, float)):
            return False
        if not math.isfinite(v):
            return False
        if v < 0:
            return False
    return True

def postcondition(input, output):
    x, y = input
    lo = min(x, y)
    hi = max(x, y)
    # If output is -1, ensure there is no even integer in [lo, hi]
    if output == -1:
        a = math.ceil(lo)
        if a > hi:
            return True
        e = a if (a % 2 == 0) else (a + 1)
        return not (e <= hi)
    # Otherwise output must be an int, even, within [lo, hi], and maximal among evens
    if not isinstance(output, int):
        return False
    if output % 2 != 0:
        return False
    if not (lo <= output <= hi):
        return False
    # No larger even integer should fit in the interval
    if output + 2 <= hi:
        return False
    return True

def _impl(x, y):
    """This function takes two positive numbers x and y and returns the
    biggest even integer number that is in the range [x, y] inclusive. If 
    there's no such number, then the function should return -1.

    For example:
    choose_num(12, 15) = 14
    choose_num(13, 12) = -1"""
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def choose_num(x, y):
    _input = (x, y)
    assert precondition(_input)
    _output = _impl(x, y)
    assert postcondition(_input, _output)
    return _output
