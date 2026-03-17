
def precondition(input):
    x, y = input
    return isinstance(x, (int, float)) and isinstance(y, (int, float)) and x > 0 and y > 0

def postcondition(input, output):
    x, y = input
    if x > y:
        return output == -1
    
    evens = [i for i in range(int(x), int(y) + 1) if i % 2 == 0]
    if not evens:
        return output == -1
    else:
        return output == max(evens)

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
