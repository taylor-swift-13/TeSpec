
def precondition(inp):
    return isinstance(inp, tuple) and len(inp) == 2 and isinstance(inp[0], int) and isinstance(inp[1], int)

def postcondition(inp, out):
    a, b = inp
    return out == (abs(a) % 10) * (abs(b) % 10)

def _impl(a, b):
    """Complete the function that takes two integers and returns 
    the product of their unit digits.
    Assume the input is always valid.
    Examples:
    multiply(148, 412) should return 16.
    multiply(19, 28) should return 72.
    multiply(2020, 1851) should return 0.
    multiply(14,-15) should return 20."""
    return int(str(a)[-1]) * int(str(b)[-1])

def multiply(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
