
def precondition(inp):
    return isinstance(inp[0], int) and inp[0] >= 0

def postcondition(inp, out):
    n = inp[0]
    return out == n * (n + 1) // 2

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
