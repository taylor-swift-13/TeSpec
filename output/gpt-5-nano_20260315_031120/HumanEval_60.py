
def precondition(input):
    # input should be a tuple of exactly one element, which must be an int
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    return True

def postcondition(input, output):
    # Ensure input is valid
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    # For n >= 1, expect output == n*(n+1)//2
    if n >= 1:
        return isinstance(output, int) and output == n * (n + 1) // 2
    # For n < 1, no specific expectation
    return True

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
