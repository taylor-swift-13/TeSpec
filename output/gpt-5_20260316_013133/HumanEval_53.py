
def precondition(input):
    return isinstance(input, tuple) and len(input) == 2 and all(type(v) is int for v in input)

def postcondition(input, output):
    if not precondition(input):
        return True
    x, y = input
    if type(output) is not int:
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
