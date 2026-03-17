
def precondition(args):
    x, y = args
    return isinstance(x, int) and isinstance(y, int)

def postcondition(args, output):
    x, y = args
    return isinstance(output, int) and output == x + y

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
