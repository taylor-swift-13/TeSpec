
def precondition(input):
    n = input[0]
    return isinstance(n, int)

def postcondition(input, output):
    n = input[0]
    if output:
        return n >= 8 and n % 2 == 0
    else:
        return n < 8 or n % 2 != 0

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
