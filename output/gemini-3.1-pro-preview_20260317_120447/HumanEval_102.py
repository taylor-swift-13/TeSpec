
def precondition(inp):
    x, y = inp
    return isinstance(x, (int, float)) and isinstance(y, (int, float)) and x > 0 and y > 0

def postcondition(inp, out):
    x, y = inp
    start = int(x) + (1 if x > int(x) else 0)
    end = int(y)
    
    if out == -1:
        return all(i % 2 != 0 for i in range(start, end + 1))
    
    if not isinstance(out, (int, float)):
        return False
        
    expected = end if end % 2 == 0 else end - 1
    return expected >= start and out == expected

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
