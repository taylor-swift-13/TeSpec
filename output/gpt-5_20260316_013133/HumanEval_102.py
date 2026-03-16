
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, y = input
    def is_pos_number(v):
        return (
            isinstance(v, (int, float))
            and not isinstance(v, bool)
            and v == v
            and v != float('inf')
            and v != -float('inf')
            and v > 0
        )
    return is_pos_number(x) and is_pos_number(y)

def postcondition(input, output):
    if not precondition(input):
        return True
    x, y = input
    if x > y:
        return output == -1
    # Compute floor(y) for positive y
    hi = y if isinstance(y, int) else int(y)
    # Largest even integer <= y
    if hi % 2 != 0:
        hi -= 1
    # Compute ceil(x) for positive x
    if isinstance(x, int):
        low = x
    else:
        ix = int(x)
        low = ix if x == ix else ix + 1
    if hi < low:
        return output == -1
    return isinstance(output, int) and not isinstance(output, bool) and output == hi

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
