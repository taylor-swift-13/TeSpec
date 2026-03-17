
def precondition(input):
    (n,) = input
    return isinstance(n, int)

def postcondition(input, output):
    (n,) = input
    if not isinstance(output, bool):
        return False
    # The sum of 4 positive even numbers has minimum value 2+2+2+2=8
    # and must be even. So result is True iff n >= 8 and n is even.
    expected = (n >= 8 and n % 2 == 0)
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
