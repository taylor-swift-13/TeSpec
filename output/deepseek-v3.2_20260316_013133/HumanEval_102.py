
def precondition(input):
    x, y = input
    return isinstance(x, (int, float)) and isinstance(y, (int, float)) and x > 0 and y > 0

def postcondition(input, output):
    x, y = input
    if not isinstance(output, (int, float)):
        return False
    if output == -1:
        lower = min(x, y)
        upper = max(x, y)
        for num in range(int(lower), int(upper) + 1):
            if num % 2 == 0:
                return False
        return True
    else:
        if output % 2 != 0:
            return False
        lower = min(x, y)
        upper = max(x, y)
        if not (lower <= output <= upper):
            return False
        for num in range(int(output) + 2, int(upper) + 1, 2):
            if num % 2 == 0:
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
