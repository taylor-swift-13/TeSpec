
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, (int, float)) and not isinstance(n, bool)

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    n = input[0]
    # n can be written as sum of exactly 4 positive even numbers
    # minimum sum is 2+2+2+2=8, and n must be even
    if isinstance(n, int):
        expected = (n >= 8) and (n % 2 == 0)
        return output == expected
    return True

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
