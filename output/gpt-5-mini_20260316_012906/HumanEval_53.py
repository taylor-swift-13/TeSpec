
def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 2:
            return False
        x, y = input
        return isinstance(x, int) and isinstance(y, int)
    except Exception:
        return False

def postcondition(input, output) -> bool:
    # If precondition does not hold, don't enforce postcondition here.
    if not precondition(input):
        return True
    try:
        x, y = input
        return isinstance(output, int) and output == x + y
    except Exception:
        return False

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
