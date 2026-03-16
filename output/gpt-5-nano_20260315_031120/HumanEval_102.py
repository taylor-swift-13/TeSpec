
def precondition(args):
    if not isinstance(args, tuple) or len(args) != 2:
        return False
    x, y = args
    if not isinstance(x, (int, float)) or not isinstance(y, (int, float)):
        return False
    if isinstance(x, float) and (x != x):
        return False
    if isinstance(y, float) and (y != y):
        return False
    if x <= 0 or y <= 0:
        return False
    return True

def postcondition(args, output):
    if not precondition(args):
        return False
    import math
    x, y = args
    if x > y:
        expected = -1
    else:
        n = math.floor(y)
        if n % 2 != 0:
            n -= 1
        if n < x:
            expected = -1
        else:
            expected = int(n)
    return output == expected

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
