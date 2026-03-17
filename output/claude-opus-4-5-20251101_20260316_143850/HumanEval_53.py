
def precondition(input):
    if len(input) != 2:
        return False
    x, y = input
    if not isinstance(x, int) or isinstance(x, bool):
        return False
    if not isinstance(y, int) or isinstance(y, bool):
        return False
    return True

def postcondition(input, output):
    x, y = input
    if not isinstance(output, int):
        return False
    return output == x + y

def _impl(x: int, y: int):
    """Add two numbers x and y
    5
    12"""
    return x + y

def add(x: int, y: int):
    _input = (x, y)
    assert precondition(_input)
    _output = _impl(x, y)
    assert postcondition(_input, _output)
    return _output
