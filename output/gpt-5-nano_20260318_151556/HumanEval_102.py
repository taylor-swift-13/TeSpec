
def precondition(input):
    import math
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, y = input
    if not isinstance(x, (int, float)) or not isinstance(y, (int, float)):
        return False
    if not (math.isfinite(x) and math.isfinite(y)):
        return False
    if x <= 0 or y <= 0:
        return False
    return True

def postcondition(input, output):
    import math
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, y = input
    if not isinstance(x, (int, float)) or not isinstance(y, (int, float)):
        return False
    if not (math.isfinite(x) and math.isfinite(y)):
        return False
    if not isinstance(output, int):
        return False

    low = min(x, y)
    high = max(x, y)
    start = math.ceil(low)
    end = math.floor(high)

    if start > end:
        expected = -1
        return output == expected

    candidate = end if end % 2 == 0 else end - 1
    if candidate >= start:
        expected = candidate
    else:
        expected = -1

    return output == expected

def _impl(x, y):
    """
    This function takes two positive numbers x and y and returns the
    biggest even integer number that is in the range [x, y] inclusive. If 
    there's no such number, then the function should return -1.

    For example:
    choose_num(12, 15) = 14
    choose_num(13, 12) = -1
    """
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def choose_num(x, y):
    _input = (x, y)
    assert precondition(_input)
    _output = _impl(x, y)
    assert postcondition(_input, _output)
    return _output
