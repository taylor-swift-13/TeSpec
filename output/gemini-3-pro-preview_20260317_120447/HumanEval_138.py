
def precondition(args):
    n = args[0]
    return isinstance(n, (int, float))

def postcondition(args, output):
    n = args[0]
    if isinstance(n, int):
        expected = n >= 8 and n % 2 == 0
    elif isinstance(n, float) and n.is_integer():
        expected = int(n) >= 8 and int(n) % 2 == 0
    else:
        expected = False
    return output == expected

def _impl(n):
    """Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
    Example
    is_equal_to_sum_even(4) == False
    is_equal_to_sum_even(6) == False
    is_equal_to_sum_even(8) == True"""
    return n >= 8 and n % 2 == 0

def is_equal_to_sum_even(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
