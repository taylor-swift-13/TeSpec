
def precondition(input):
    a, b = input
    return isinstance(a, int) and isinstance(b, int)

def postcondition(input, output):
    a, b = input
    if not isinstance(output, int):
        return False
    unit_a = abs(a) % 10
    unit_b = abs(b) % 10
    return output == unit_a * unit_b

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
