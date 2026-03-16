
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, int) and not isinstance(n, bool) and n >= 0

def postcondition(input, output):
    if not precondition(input):
        return True
    n = input[0]
    t = n * (n + 1) // 2
    if isinstance(output, bool):
        return False
    if isinstance(output, int):
        return output == t
    if isinstance(output, float):
        return output.is_integer() and int(output) == t
    return False

def _impl(n: int):
    """sum_to_n is a function that sums numbers from 1 to n.
    465
    5050
    15
    55
    1"""
    return (n + 1) * n // 2

def sum_to_n(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
