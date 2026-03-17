
def precondition(input):
    return len(input) == 2 and isinstance(input[0], int) and isinstance(input[1], int)

def postcondition(input, output):
    return output == input[0] + input[1]

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
