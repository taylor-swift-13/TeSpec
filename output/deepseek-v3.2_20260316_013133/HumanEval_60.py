
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 0

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, int):
        return False
    if n < 0:
        return result == 0
    expected = n * (n + 1) // 2
    return result == expected

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
