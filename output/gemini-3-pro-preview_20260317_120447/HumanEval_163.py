
def precondition(input_args):
    a, b = input_args
    return isinstance(a, int) and isinstance(b, int) and a > 0 and b > 0

def postcondition(input_args, output):
    a, b = input_args
    if not isinstance(output, list):
        return False
    
    lower, upper = min(a, b), max(a, b)
    expected = [d for d in [0, 2, 4, 6, 8] if lower <= d <= upper]
    
    return output == expected

def _impl(a, b):
    """Given two positive integers a and b, return the even digits between a
    and b, in ascending order.

    For example:
    generate_integers(2, 8) => [2, 4, 6, 8]
    generate_integers(8, 2) => [2, 4, 6, 8]
    generate_integers(10, 14) => []"""
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def generate_integers(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
